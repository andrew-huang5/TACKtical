//
//  HorseViewModel.swift
//  TACKtical
//
//
import Foundation
import FirebaseFirestore

class HorseViewModel: ObservableObject {
    
    @Published var horse = Horse(id: "", arrivalDate: Date(), height: 0, gender: 0, birth: Date(), owner: "", feed: 0, color: 0, name: "", ownerName: "")
    @Published var horses = [Horse]()
    
    private var db = Firestore.firestore()
   
    
    
    func fetchAllData() {
        db.collection("HorseProfiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.horses = documents.map{ (queryDocumentSnapshot) -> Horse in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let arrivalDate_string = data["Arrival Date"] as? String ?? ""
                let height = data["Height"] as? Int ?? 0
                let gender = data["Gender"] as? Int ?? 0
                let birth_string = data["Date of Birth"] as? String ?? ""
                let owner = data["Owner"] as? String ?? ""
                let feed = data["Feed"] as? Int ?? 0
                let color = data["Color"] as? Int ?? 0
                let name = data["name"] as? String ?? ""
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .medium
                let birth = formatter1.date(from: birth_string)!
                let arrivalDate = formatter1.date(from: arrivalDate_string)!
                let ownerName = data["Owner Name"] as? String ?? ""
                
                return Horse(id: id, arrivalDate: arrivalDate, height: height, gender: gender, birth: birth , owner: owner, feed: feed, color: color, name: name, ownerName: ownerName)
            }
        }
    }
    
    func fetchData(id:String){
        db.collection("HorseProfiles").document(id).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let p = document!.data()!
                    let id = p["ID"] as? String ?? ""
                    let arrivalDate_string = p["Arrival Date"] as? String ?? ""
                    let height = p["Height"] as? Int ?? 0
                    let gender = p["Gender"] as? Int ?? 0
                    let birth_string = p["Date of Birth"] as? String ?? ""
                    let owner = p["Owner"] as? String ?? ""
                    let feed = p["Feed"] as? Int ?? 0
                    let color = p["Color"] as? Int ?? 0
                    let name = p["name"] as? String ?? ""
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .medium
                    let birth = formatter1.date(from: birth_string)!
                    let arrivalDate = formatter1.date(from: arrivalDate_string)!
                    let ownerName = p["Owner Name"] as? String ?? ""
                    
                    self.horse = Horse(id: id, arrivalDate: arrivalDate, height: height, gender: gender, birth: birth, owner: owner, feed: feed, color: color, name: name, ownerName: ownerName)
                    
                }
            }
        }
    }
    
}
