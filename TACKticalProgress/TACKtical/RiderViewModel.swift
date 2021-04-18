//
//  RiderViewModel.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/17/21.
//

import Foundation
import FirebaseFirestore

class RiderViewModel: ObservableObject {
    
    @Published var rider = Rider(id: "", joinedDate: Date(), height: 0, gender: 0, age: 0, horse: "", name: "", email: "", phone: "")
    @Published var riders = [Rider]()
    
    private var db = Firestore.firestore()
   
    
    
//    func fetchAllData() {
//        db.collection("RiderProfiles").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.riders = documents.map{ (queryDocumentSnapshot) -> Rider in
//                let data = queryDocumentSnapshot.data()
//                let id = data["ID"] as? String ?? ""
//                let joinedDate_string = data["Joined Date"] as? String ?? ""
//                let height = data["Height"] as? Int ?? 0
//                let gender = data["Gender"] as? Int ?? 0
//                let birth_string = data["Date of Birth"] as? String ?? ""
//                let owner = data["Owner"] as? String ?? ""
//                let feed = data["Feed"] as? Int ?? 0
//                let color = data["Color"] as? Int ?? 0
//                let name = data["name"] as? String ?? ""
//                let formatter1 = DateFormatter()
//                formatter1.dateStyle = .medium
//                let birth = formatter1.date(from: birth_string)!
//                let arrivalDate = formatter1.date(from: arrivalDate_string)!
//
//                return Horse(id: id, arrivalDate: arrivalDate, height: height, gender: gender, birth: birth , owner: owner, feed: feed, color: color, name: name)
//            }
//        }
//    }
//
//    func fetchData(id:String){
//        db.collection("RiderProfiles").document(id).getDocument { (document, error) in
//            if error == nil {
//                if document != nil && document!.exists {
//                    let p = document!.data()!
//                    let id = p["ID"] as? String ?? ""
//                    let arrivalDate_string = p["Arrival Date"] as? String ?? ""
//                    let height = p["Height"] as? Int ?? 0
//                    let gender = p["Gender"] as? Int ?? 0
//                    let birth_string = p["Date of Birth"] as? String ?? ""
//                    let owner = p["Owner"] as? String ?? ""
//                    let feed = p["Feed"] as? Int ?? 0
//                    let color = p["Color"] as? Int ?? 0
//                    let name = p["name"] as? String ?? ""
//                    let formatter1 = DateFormatter()
//                    formatter1.dateStyle = .medium
//                    let birth = formatter1.date(from: birth_string)!
//                    let arrivalDate = formatter1.date(from: arrivalDate_string)!
//
//                    self.horse = Horse(id: id, arrivalDate: arrivalDate, height: height, gender: gender, birth: birth, owner: owner, feed: feed, color: color, name: name)
//
//                }
//            }
//        }
//    }
    
}
