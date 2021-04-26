//
//  EventViewModel.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/25/21.
//

import Foundation
import Firebase

class EventViewModel: ObservableObject {
    
    @Published var event = Event(id: "", horseID: "", horseName: "", riderID: "", riderName: "", type: "", title: "", start: Date(), end: Date())
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
    let formatter = DateFormatter()
    
    
    func fetchAllData() {
        db.collection("Users").document("2C119956-AD83-4787-B3DD-AA2F3718D9DB").collection("Events").addSnapshotListener { (querySnapshot, error) in
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
                let start = (data["start"] as? Timestamp)?.dateValue() ?? Date()
                let end = (data["end"] as? Timestamp)?.dateValue() ?? Date()
                
                return Event(id: id, horseID: horseID, horseName: horseName, riderID: riderID, riderName: riderName, type: type, title: title, start: start, end: end)
            }
        }
    }
    
    func fetchData(id:String){
        db.collection("Users").document("2C119956-AD83-4787-B3DD-AA2F3718D9DB").collection("Events").document(id).getDocument { (document, error) in
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
                    let start = p["start"] as? Date ?? Date()
                    let end = p["end"] as? Date ?? Date()
                    
                    self.event = Event(id: id, horseID: horseID, horseName: horseName, riderID: riderID, riderName: riderName, type: type, title: title, start: start, end: end)
                }
            }
        }
    }
    
}
