//
//  EventViewModel.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/25/21.
//
import Foundation
import Firebase

class EventViewModel: ObservableObject {
    
    @Published var event = Event(id: "", horseID: "", horseName: "", riderID: "", riderName: "", type: "", title: "", date: "", startTime: Date(), startTimeString: "", endTime: Date(), endTimeString: "")
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
    let formatter = DateFormatter()
    
    
    func fetchAllData() {
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Events").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.events = documents.map{ (queryDocumentSnapshot) -> Event in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let horseID = data["horseID"] as? String ?? ""
                let horseName = data["horseName"] as? String ?? ""
                let riderID = data["riderID"] as? String ?? ""
                let riderName = data["riderName"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let startTime = data["startTime"] as? String ?? ""
                let endTime = data["endTime"] as? String ?? ""
                let timeFormatter = DateFormatter()
                timeFormatter.timeStyle = .short
                
                
                return Event(id: id, horseID: horseID, horseName: horseName, riderID: riderID, riderName: riderName, type: type, title: title, date: date, startTime: timeFormatter.date(from: startTime) ?? Date(), startTimeString: startTime, endTime: timeFormatter.date(from: endTime) ?? Date(), endTimeString: endTime)
            }
        }
    }
    
    func fetchData(id:String){
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("Events").document(id).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let p = document!.data()!
                    let id = p["id"] as? String ?? ""
                    let horseID = p["horseID"] as? String ?? ""
                    let horseName = p["horseName"] as? String ?? ""
                    let riderID = p["riderID"] as? String ?? ""
                    let riderName = p["riderName"] as? String ?? ""
                    let type = p["type"] as? String ?? ""
                    let title = p["title"] as? String ?? ""
                    let date = p["date"] as? String ?? ""
                    let startTime = p["startTime"] as? String ?? ""
                    let endTime = p["endTime"] as? String ?? ""
                    let timeFormatter = DateFormatter()
                    timeFormatter.timeStyle = .short
                    
                    self.event = Event(id: id, horseID: horseID, horseName: horseName, riderID: riderID, riderName: riderName, type: type, title: title, date: date, startTime: timeFormatter.date(from: startTime) ?? Date(), startTimeString: startTime, endTime: timeFormatter.date(from: endTime) ?? Date(), endTimeString: endTime)
                }
            }
        }
    }
    
}
