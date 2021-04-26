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
        VStack {
            NavigationLink(destination: AddEventView(type: "Lesson", start: date, end: date.addingTimeInterval(3600))) {
                Text("Lesson")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(type: "Training", start: date, end: date.addingTimeInterval(3600))) {
                Text("Training Ride")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(type: "Vet", start: date, end: date.addingTimeInterval(3600))) {
                Text("Vet")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(type: "Farrier", start: date, end: date.addingTimeInterval(3600))) {
                Text("Farrier")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(type: "Custom", start: date,
                                                     end: date.addingTimeInterval(3600))) {
                Text("Custom")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .leading)
        }.navigationBarTitle("Choose Event Type")
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
    
    var body: some View {
        VStack{
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
                            CustomRiderSearchBar(riders: $riderViewModel.riders, rider: $riderID, riderName: $riderName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: "").onAppear(){riderViewModel.fetchAllData()}
                        }
                    }
                    VStack() {
                        Button(action: {upload()}){
                            Text("Done").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16)
                    }
                }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("New " + type + " Event")
                }
            }
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
    }
}
