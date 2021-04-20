//
//  InstructorViewModel.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/19/21.
//

import Foundation
import FirebaseFirestore

class InstructorViewModel: ObservableObject {
    
    @Published var instructor = Instructor(id: "", joinedDate: Date(), height: 0, gender: 0, age: 0, student: "", name: "", email: "", phone: "", studentName: "")
    @Published var instructors = [Instructor]()
    
    private var db = Firestore.firestore()
   
    
    
    func fetchAllData() {
        db.collection("InstructorProfiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.instructors = documents.map{ (queryDocumentSnapshot) -> Instructor in
                let data = queryDocumentSnapshot.data()
                let id = data["ID"] as? String ?? ""
                let joinedDate_string = data["Joined Date"] as? String ?? ""
                let height = data["Height"] as? Int ?? 0
                let gender = data["Gender"] as? Int ?? 0
                let age = data["Age"] as? Int ?? 0
                let student = data["Student"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let email = data["Email"] as? String ?? ""
                let phone = data["Phone"] as? String ?? ""
                let studentName = data["Student Name"] as? String ?? ""
                
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .medium
                let joinedDate = formatter1.date(from: joinedDate_string)!
                
                return Instructor(id: id, joinedDate: joinedDate, height: height, gender: gender, age: age, student: student, name: name, email: email, phone: phone, studentName: studentName)
            }
        }
    }
    
    func fetchData(id:String){
        db.collection("InstructorProfiles").document(id).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let data = document!.data()!
                    let id = data["ID"] as? String ?? ""
                    let joinedDate_string = data["Joined Date"] as? String ?? ""
                    let height = data["Height"] as? Int ?? 0
                    let gender = data["Gender"] as? Int ?? 0
                    let age = data["Age"] as? Int ?? 0
                    let student = data["Student"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let email = data["Email"] as? String ?? ""
                    let phone = data["Phone"] as? String ?? ""
                    let studentName = data["Student Name"] as? String ?? ""
                    
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .medium
                    let joinedDate = formatter1.date(from: joinedDate_string)!
                    
                    self.instructor = Instructor(id: id, joinedDate: joinedDate, height: height, gender: gender, age: age, student: student, name: name, email: email, phone: phone, studentName: studentName)
                    
                }
            }
        }
    }
    
}

