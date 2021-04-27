//
//  CalendarView.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/8/21.
//
import Foundation
import SwiftUI
import Firebase

struct ChooseEventView: View {
    @State var date: Date
    var body: some View {
        Group{
            VStack(spacing: UIScreen.main.bounds.height*0.05) {
                NavigationLink(destination: AddEventView(type: "Lesson", start: date, end: date.addingTimeInterval(3600))) {
                    Text("Lesson")
                }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                NavigationLink(destination: AddEventView(type: "Training", start: date, end: date.addingTimeInterval(3600))) {
                    Text("Training Ride")
                }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                NavigationLink(destination: AddEventView(type: "Vet", start: date, end: date.addingTimeInterval(3600))) {
                    Text("Vet")
                }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                NavigationLink(destination: AddEventView(type: "Farrier", start: date, end: date.addingTimeInterval(3600))) {
                    Text("Farrier")
                }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                NavigationLink(destination: AddEventView(type: "Custom", start: date,
                                                         end: date.addingTimeInterval(3600))) {
                    Text("Custom")
                }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
            }.navigationBarTitle("Choose Event Type")
            
            MenuView().padding(EdgeInsets(top: UIScreen.main.bounds.height*0.2, leading: 0, bottom: 0, trailing: 0))
        }.frame(maxHeight: .infinity, alignment: .bottom)
        
        
    }
}



struct AddEventView: View {
    @ObservedObject private var viewModel = EventViewModel()
    @ObservedObject private var horseViewModel = HorseViewModel()
    @ObservedObject private var riderViewModel = RiderViewModel()
    let dateFormatter = DateFormatter()
    
    var type: String
    @State var start: Date
    @State var end: Date
    @State var title = ""
    @State var horseID = ""
    @State var horseName = ""
    @State var riderID = ""
    @State var riderName = ""
    @State var prevHorse = ""
    @State var prevOwner = ""
    @State var prevInstructor = ""
    @State private var showPopUp: Bool = false
    @State private var finishDone: Bool = false
    
    var body: some View {
        ZStack{
            Form {
                Section {
                    VStack {
                        Text(dateFormatter.string(from: start)).onAppear() {
                            dateFormatter.dateStyle = .medium
                        }
                    }
                    HStack() {
                        Text("Title: ").foregroundColor(.blue)
                        TextField("Enter new title", text: $title)
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.01, leading: 0, bottom: UIScreen.main.bounds.height * 0.01, trailing: 0))
                    VStack(alignment: .leading) {
                        Text("Start Time:").foregroundColor(.blue)
                        DatePicker("", selection: $start, displayedComponents: [.hourAndMinute])
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.01, leading: 0, bottom: UIScreen.main.bounds.height * 0.01, trailing: 0))
                    VStack(alignment: .leading) {
                        Text("End Time:").foregroundColor(.blue)
                        DatePicker("", selection: $end, displayedComponents: [.hourAndMinute])
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.01, leading: 0, bottom: UIScreen.main.bounds.height * 0.01, trailing: 0))
                    VStack{
                        Text("Choose horse: ")
                        CustomHorseSearchBar(horses: $horseViewModel.horses, horse: $horseID, horseName: $horseName, prevOwner: $prevOwner, txt: "").onAppear(){horseViewModel.fetchAllData()}
                    }
                    if type == "Lesson" || type == "Training" || type == "Custom" {
                        VStack {
                            Text("Choose student: ")
                            CustomRiderSearchBar(riders: riderViewModel.riders, rider: $riderID, riderName: $riderName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: "").onAppear(){riderViewModel.fetchAllData()}
                        }
                    }
                    if finishDone == false{
                        VStack() {
                            Button(action: {upload()}){
                                Text("Done").font(.system(size:UIScreen.main.bounds.height*0.025))
                            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16)
                        }
                    }
                    
                }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("New " + type + " Event")
                }
            GeneralPopUpWindow(title: "Notice", message: "Event Created!", buttonText: "OK", show: $showPopUp)
        }
        MenuView()
    }
    
    func upload() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .short
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm"
        let uuid = UUID().uuidString
        let id = formatter1.string(from: start) + formatter3.string(from:start) + uuid
        
        
        let db = Firestore.firestore()
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Events").document(id).setData(["id": id, "horseID": horseID, "horseName": horseName, "riderID": riderID, "riderName": riderName, "type": type, "title": title, "date": formatter1.string(from: start), "startTime": formatter2.string(from: start), "endTime": formatter2.string(from: end)], merge:true)
        self.showPopUp.toggle()
        self.finishDone.toggle()
    }
}
