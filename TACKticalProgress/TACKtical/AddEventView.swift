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
    var body: some View {
        let eventID = UUID().uuidString
        VStack {
            NavigationLink(destination: AddEventView(id: eventID, type: "Lesson")) {
                Text("Lesson")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(id: eventID, type: "Training")) {
                Text("Training Ride")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(id: eventID, type: "Vet")) {
                Text("Vet")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(id: eventID, type: "Farrier")) {
                Text("Farrier")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
            NavigationLink(destination: AddEventView(id: eventID, type: "Custom")) {
                Text("Custom")
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .leading)
        }.navigationBarTitle("Choose Event Type")
    }
}



struct AddEventView: View {
    @ObservedObject private var viewModel = EventViewModel()
    
    var id: String
    var type: String
    @State var title = ""
    @State var start = Date()
    @State var end = Date().addingTimeInterval(3600)
    @State var horseID = ""
    
    var body: some View {
        VStack{
            Form {
                Section {
                    HStack() {
                        Text("Title: ").foregroundColor(.blue)
                        TextField("Enter new title", text: $title)
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.01, leading: 0, bottom: UIScreen.main.bounds.height * 0.01, trailing: 0))
                    VStack(alignment: .leading) {
                        Text("Start:").foregroundColor(.blue)
                        DatePicker("", selection: $start, displayedComponents: [.date, .hourAndMinute])
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.01, leading: 0, bottom: UIScreen.main.bounds.height * 0.01, trailing: 0))
                    VStack(alignment: .leading) {
                        Text("End:").foregroundColor(.blue)
                        DatePicker("", selection: $end, displayedComponents: [.date, .hourAndMinute])
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.01, leading: 0, bottom: UIScreen.main.bounds.height * 0.01, trailing: 0))
                    VStack{
                        Text("Choose horse: ")
                        Dropdown1()
                    }
                    if type == "Lesson" || type == "Training" || type == "Custom" {
                        VStack {
                            Text("Choose rider: ")
                            Dropdown2()
                        }
                        VStack {
                            Text("Choose instructor: ")
                            Dropdown3()
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
        let db = Firestore.firestore()
        db.collection("Events").document(id).setData(["id": id, "horseID": horseID, "riderID": riderID, "instructorID": instructorID, "type": type, "title": title, "start": start, "end": end], merge:true)
    }
}
