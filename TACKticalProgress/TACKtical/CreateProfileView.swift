//
//  CreateProfileView.swift
//  TACKtical
//
//
import SwiftUI
import Firebase

struct CreateProfileView: View {
    @ObservedObject private var viewModel = HorseViewModel()
    @State var name = ""
    @State var birth = ""
    @State var gender = ""
    @State var color = ""
    @State var height = ""
    @State var owner = ""
    @State var arrival = ""
    @State var feed = ""
    var body: some View {
        VStack {
            VStack{
                HStack() {
                    Text("Name: ").foregroundColor(.blue)
                    TextField("Enter name", text: $name)
                }
                
                HStack() {
                    Text("Date of Birth: ").foregroundColor(.blue)
                    TextField("Enter date", text: $birth)
                }
                
                HStack() {
                    Text("Gender: ").foregroundColor(.blue)
                    TextField("Enter gender", text: $gender)
                }
                
                HStack() {
                    Text("Color: ").foregroundColor(.blue)
                    TextField("Enter color", text: $color)
                }
                
                HStack() {
                    Text("Height: ").foregroundColor(.blue)
                    TextField("Enter height", text: $height)
                }
                
                HStack() {
                    Text("Owner: ").foregroundColor(.blue)
                    TextField("Enter owner", text: $owner)
                }
                
                HStack() {
                    Text("Arrival Date: ").foregroundColor(.blue)
                    TextField("Enter date", text: $arrival)
                }
                
                HStack() {
                    Text("Feed: ").foregroundColor(.blue)
                    TextField("Enter feed", text: $feed)
                }
                
                Button(action: {upload()}){
                    Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            }
            NavigationLink(destination: NewProfileView(name: name)) {
                Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Create Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        db.collection("Profiles").document(name).setData(["Arrival Date": arrival, "Color": color, "Date of Birth": birth, "Feed": feed, "Gender": gender, "Height": height, "Owner": owner, "name":name], merge:true)
    }
    
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}
