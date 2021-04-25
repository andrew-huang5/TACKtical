//
//  NameViewModel.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/24/21.
//

import Foundation
import Firebase

class NameViewModel: ObservableObject {
    @Published var ObjectNames = [ObjectName]()
    private var db = Firestore.firestore()
    
    func fetchAllData() {
        
        db.collection("HorseProfiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.ObjectNames = []
            self.ObjectNames += documents.map{ (queryDocumentSnapshot) -> ObjectName in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                
                return ObjectName(id: id, name: name, type: "Horse")
            }
        }
        db.collection("RiderProfiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.ObjectNames += documents.map{ (queryDocumentSnapshot) -> ObjectName in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                
                
                return ObjectName(id: id, name: name, type: "Rider")
            }
        }
        db.collection("InstructorProfiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.ObjectNames += documents.map{ (queryDocumentSnapshot) -> ObjectName in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                
                return ObjectName(id: id, name: name, type: "Instructor")
            }
        }
        
        
    }
}
