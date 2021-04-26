//
//  EditEventView.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/25/21.
//
import SwiftUI
import Firebase

struct EditEventView: View {
    @ObservedObject private var viewModel = EventViewModel()
    @ObservedObject private var horseViewModel = HorseViewModel()
    @ObservedObject private var riderViewModel = RiderViewModel()
    let dateFormatter = DateFormatter()
    
    var type: String
    @State var eventID: String
    @State var start: Date
    @State var end: Date
    @State var date: String
    @State var title: String
    @State var horseID = ""
    @State var horseName: String
    @State var riderID = ""
    @State var riderName: String
    @State var prevHorse = ""
    @State var prevOwner = ""
    @State var prevInstructor = ""
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            VStack{
                Form {
                    Section {
                        VStack {
                            Text(date).onAppear() {
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
                            CustomHorseSearchBar(horses: $horseViewModel.horses, horse: $horseID, horseName: $horseName, prevOwner: $prevOwner, txt: horseName).onAppear(){horseViewModel.fetchAllData()}
                        }
                        if type == "Lesson" || type == "Training" || type == "Custom" {
                            VStack {
                                Text("Choose student: ")
                                CustomRiderSearchBar(riders: riderViewModel.riders, rider: $riderID, riderName: $riderName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: riderName).onAppear(){riderViewModel.fetchAllData()}
                            }
                        }
                        VStack() {
                            Button(action: {upload()}){
                                Text("Done").font(.system(size:UIScreen.main.bounds.height*0.025))
                            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16)
                        }
                        Button(action: {
                            self.showPopUp.toggle()
                        }){
                            Text("Delete Event").foregroundColor(Color(.red))
                        }
                    }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("New " + type + " Event")
                    }
                }
            PopUpWindowforEvent(title: "Notice", message: "You sure about this?", buttonText1: "Yes", buttonText2: "No", show: $showPopUp, eventID: eventID)
        }
        MenuView()
    }
    
    func upload() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .short
        
        let db = Firestore.firestore()
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Events").document(eventID).setData(["id": eventID, "horseID": horseID, "horseName": horseName, "riderID": riderID, "riderName": riderName, "type": type, "title": title, "date": formatter1.string(from: start), "startTime": formatter2.string(from: start), "endTime": formatter2.string(from: end)], merge:true)
    }
}
