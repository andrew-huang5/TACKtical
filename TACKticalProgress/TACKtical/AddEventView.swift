//
//  CalendarView.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/8/21.
//
import Foundation
import SwiftUI
import Firebase

struct AddEventView: View {
    @State var title = ""
    @State var rep = false
    @State var notify = false
    @State var type = "Lesson"
    
    @State var start: Date
    @State var end: Date
    
    var body: some View {
        VStack{
            HStack() {
                Text("Title: ").foregroundColor(.blue)
                TextField("Enter new title", text: $title)
            }.padding(UIScreen.main.bounds.height * 0.025)
            VStack(alignment: .leading) {
                Text("Start:").foregroundColor(.blue)
                DatePicker("", selection: $start, displayedComponents: [.date, .hourAndMinute])
            }.padding(UIScreen.main.bounds.height * 0.025)
            VStack(alignment: .leading) {
                Text("End:").foregroundColor(.blue)
                DatePicker("", selection: $end, displayedComponents: [.date, .hourAndMinute])
            }.padding(UIScreen.main.bounds.height * 0.025)
            HStack() {
                Text("Repeat").foregroundColor(.blue)
                Toggle(isOn: $rep) {
                }
            }.padding(UIScreen.main.bounds.height * 0.025)
            HStack() {
                Text("Notify").foregroundColor(.blue)
                Toggle(isOn: $notify) {
                }
            }.padding(UIScreen.main.bounds.height * 0.025)
            VStack() {
                Button(action: {upload()}){
                    Text("Done").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            }
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("New Event")
    }
    
    func upload() {
        let db = Firestore.firestore()
        db.collection("Events").document("Event3").setData(["title": title, "start": start, "end": end, "type": type, "notify": notify, "repeat": rep], merge:true)
    }
}
