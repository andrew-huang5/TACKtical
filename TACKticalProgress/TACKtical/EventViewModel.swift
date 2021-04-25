//
//  EventViewModel.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/21/21.
//

import Foundation
import FirebaseFirestore

class EventViewModel: ObservableObject {
    
    @Published var event = Event(id: "", horseID: "", riderID: "", instructorID: "", type: "", title: "", start: Date(), end: Date())
    @Published var events = [Event]()
    
    private var db = Firestore.firestore()
   
    
    
    func fetchAllData() {
        db.collection("Events").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.events = documents.map{ (queryDocumentSnapshot) -> Event in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let horseID = data["horseID"] as? String ?? ""
                let riderID = data["riderID"] as? String ?? ""
                let instructorID = data["instructorID"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let start = data["start"] as? Date ?? Date()
                let end = data["end"] as? Date ?? Date()
                
                return Event(id: id, horseID: horseID, riderID: riderID, instructorID: instructorID, type: type, title: title, start: start, end: end)
            }
        }
    }
    
    func fetchData(id:String){
        db.collection("Events").document(id).collection("User1").document("Event1").getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let p = document!.data()!
                    let id = p["id"] as? String ?? ""
                    let horseID = p["horseID"] as? String ?? ""
                    let riderID = p["riderID"] as? String ?? ""
                    let instructorID = p["instructorID"] as? String ?? ""
                    let type = p["type"] as? String ?? ""
                    let title = p["title"] as? String ?? ""
                    let start = p["start"] as? Date ?? Date()
                    let end = p["end"] as? Date ?? Date()
                    
                    self.event = Event(id: id, horseID: horseID, riderID: riderID, instructorID: instructorID, type: type, title: title, start: start, end: end)
                }
            }
        }
    }
    
}
