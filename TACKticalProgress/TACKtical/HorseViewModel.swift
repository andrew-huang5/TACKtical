//
//  HorseViewModel.swift
//  TACKtical
//
//
import Foundation
import FirebaseFirestore

class HorseViewModel: ObservableObject {
    
    @Published var horse = Horse(arrivalDate: "", height: "", gender: "", birth: "", owner: "", feed: "", color: "", name: "")
    @Published var horses = [Horse]()
    
    private var db = Firestore.firestore()
    
    
    func fetchAllData() {
        db.collection("Profiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.horses = documents.map{ (queryDocumentSnapshot) -> Horse in
                let data = queryDocumentSnapshot.data()
                let arrivalDate = data["Arrival Date"] as? String ?? ""
                let height = data["Height"] as? String ?? ""
                let gender = data["Gender"] as? String ?? ""
                let birth = data["Date of Birth"] as? String ?? ""
                let owner = data["Owner"] as? String ?? ""
                let feed = data["Feed"] as? String ?? ""
                let color = data["Color"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                
                
                return Horse(arrivalDate: arrivalDate, height: height, gender: gender, birth: birth, owner: owner, feed: feed, color: color, name: name)
            }
        }
    }
    
    func fetchData(name:String){
        db.collection("Profiles").document(name).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let p = document!.data()!
                    let arrivalDate = p["Arrival Date"] as? String ?? ""
                    let height = p["Height"] as? String ?? ""
                    let gender = p["Gender"] as? String ?? ""
                    let birth = p["Date of Birth"] as? String ?? ""
                    let owner = p["Owner"] as? String ?? ""
                    let feed = p["Feed"] as? String ?? ""
                    let color = p["Color"] as? String ?? ""
                    let name = p["name"] as? String ?? ""
                    
                    
                    self.horse = Horse(arrivalDate: arrivalDate, height: height, gender: gender, birth: birth, owner: owner, feed: feed, color: color, name: name)
                    
                }
            }
        }
    }
}
