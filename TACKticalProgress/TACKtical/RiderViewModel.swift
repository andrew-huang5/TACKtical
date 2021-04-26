//
//  RiderViewModel.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/17/21.
//
import Foundation
import FirebaseFirestore

class RiderViewModel: ObservableObject {
    
    @Published var rider = Rider(id: "", joinedDate: Date(), height: 0, gender: 0, age: 0, horse: "", name: "", email: "", phone: "", horseName: "", instructor: "", instructorName: "")
    @Published var riders = [Rider]()
    
    private var db = Firestore.firestore()
   
    
    
    func fetchAllData() {
        db.collection("RiderProfiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.riders = documents.map{ (queryDocumentSnapshot) -> Rider in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let joinedDate_string = data["Joined Date"] as? String ?? ""
                let height = data["Height"] as? Int ?? 0
                let gender = data["Gender"] as? Int ?? 0
                let age = data["Age"] as? Int ?? 0
                let horse = data["Owned Horse"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let email = data["Email"] as? String ?? ""
                let phone = data["Phone"] as? String ?? ""
                let horseName = data["Horse Name"] as? String ?? ""
                let instructor = data["Instructor"] as? String ?? ""
                let instructorName = data["Instructor Name"] as? String ?? ""
                
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .medium
                let joinedDate = formatter1.date(from: joinedDate_string)!
                
                return Rider(id: id, joinedDate: joinedDate, height: height, gender: gender, age: age, horse: horse, name: name, email: email, phone: phone, horseName: horseName, instructor: instructor, instructorName:instructorName)
            }
        }
    }
    
    func fetchData(id:String){
        db.collection("RiderProfiles").document(id).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let data = document!.data()!
                    let id = data["ID"] as? String ?? ""
                    let joinedDate_string = data["Joined Date"] as? String ?? ""
                    let height = data["Height"] as? Int ?? 0
                    let gender = data["Gender"] as? Int ?? 0
                    let age = data["Age"] as? Int ?? 0
                    let horse = data["Owned Horse"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let email = data["Email"] as? String ?? ""
                    let phone = data["Phone"] as? String ?? ""
                    let horseName = data["Horse Name"] as? String ?? ""
                    let instructor = data["Instructor"] as? String ?? ""
                    let instructorName = data["Instructor Name"] as? String ?? ""
                    
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .medium
                    let joinedDate = formatter1.date(from: joinedDate_string)!
                    
                    self.rider = Rider(id: id, joinedDate: joinedDate, height: height, gender: gender, age: age, horse: horse, name: name, email: email, phone: phone, horseName: horseName, instructor: instructor, instructorName: instructorName)
                    print(self.rider)
                    
                }
            }
        }
    }
    
}
