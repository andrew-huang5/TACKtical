//
//  editProfile.swift
//  TACKtical
//
//

import SwiftUI
import Firebase

struct EditProfileView: View {
    @ObservedObject private var viewModel = HorseViewModel()
    @State var name = "Mayor"
    @State var birth = "Jan/1/2015"
    @State var gender = "female"
    @State var color = "Chestnut"
    @State var height = "16"
    @State var owner = "Lebron James"
    @State var arrival = "Jan/1/2020"
    @State var feed = "Grain & Hay"
    var body: some View {
        VStack {
            VStack{
                HStack() {
                    Text("Name: ").foregroundColor(.blue)
                    TextField("Enter new name", text: $name)
                }
                
                HStack() {
                    Text("Date of Birth: ").foregroundColor(.blue)
                    TextField("Enter new date of birth", text: $birth)
                }
                
                HStack() {
                    Text("Gender: ").foregroundColor(.blue)
                    TextField("Enter new horse gender", text: $gender)
                }
                
                HStack() {
                    Text("Color: ").foregroundColor(.blue)
                    TextField("Enter new horse color", text: $color)
                }
                
                HStack() {
                    Text("Height: ").foregroundColor(.blue)
                    TextField("Enter new horse height", text: $height)
                }
                
                HStack() {
                    Text("Owner: ").foregroundColor(.blue)
                    TextField("Enter new owner", text: $owner)
                }
                
                HStack() {
                    Text("Arrival Date: ").foregroundColor(.blue)
                    TextField("Enter new arrival date", text: $arrival)
                }
                
                HStack() {
                    Text("Feed: ").foregroundColor(.blue)
                    TextField("Enter new horse feed", text: $feed)
                }
                
                Button(action: {upload()}){
                    Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            }
            NavigationLink(destination: NewProfileView()) {
                Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Edit Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        db.collection("Profiles").document("Horse1").setData(["Arrival Date": arrival, "color": color, "Date of Birth": birth, "Feed": feed, "Gender": gender, "Height": height, "ID": "Horse1", "Owner": owner, "name":name], merge:true)
    }
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
