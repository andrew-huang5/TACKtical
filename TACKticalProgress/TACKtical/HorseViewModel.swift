//
//  HorseViewModel.swift
//  TACKtical
//
//  Created by 谢正恺 on 3/29/21.
//

import Foundation
import FirebaseFirestore

class HorseViewModel: ObservableObject {
    @Published var horse = Horse(arrivalDate: "", height: "", horseID: "", gender: "", birth: "", owner: "", feed: "", color: "", name: "")
    @Published var horses = [Horse]()
    
    private var db = Firestore.firestore()
    
    func fetchData(){
//        db.collection("Profiles").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.horses = documents.map{ (queryDocumentSnapshot) -> Horse in
//                let data = queryDocumentSnapshot.data
//
//                let DOB = data["DOB"] as? String ?? ""
//                let height = data["height"] as? Int ?? 0
//                let horseID = data["horseID"] as? Int ?? 0
//                let name = data["name"] as? String ?? ""
//                let weight = data["weight"] as? Int ?? 0
//
//                return Horse(DOB: DOB, height: height, horseID: horseID, name: name, weight: weight)
//            }
//        }
        db.collection("Profiles").document("Horse1").getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let p = document!.data()!
                    let arrivalDate = p["Arrival Date"] as? String ?? ""
                    let height = p["Height"] as? String ?? ""
                    let horseID = p["ID"] as? String ?? ""
                    let gender = p["Gender"] as? String ?? ""
                    let birth = p["Date of Birth"] as? String ?? ""
                    let owner = p["Owner"] as? String ?? ""
                    let feed = p["Feed"] as? String ?? ""
                    let color = p["Color"] as? String ?? ""
                    let name = p["name"] as? String ?? ""
                    
                    
                    self.horse = Horse(arrivalDate: arrivalDate, height: height, horseID: horseID, gender: gender, birth: birth, owner: owner, feed: feed, color: color, name: name)
                    
                }
            }
        }
    }
}
