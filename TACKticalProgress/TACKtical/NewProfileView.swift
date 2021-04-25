//
//  NewProfileView.swift
//  TACKtical
//
//
import SwiftUI
import SDWebImageSwiftUI
import Firebase
import Combine

let posters = [
    "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg"
].map { URL(string: $0)! }

struct NewProfileView: View {
//    @State private var editProfile = false
//    var horse = Horse(DOB: "2021", height: 16, horseID: 1, name: "Haha", weight: 200)
    var id: String
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel = HorseViewModel()
    var colorChoices = ["Bay", "Chestnut", "Gray", "Dun"]
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["10", "11", "12", "13", "14", "15", "16"]
    var feedChoices = ["Pasture Grass", "Hay", "Grains", "Salt & Minerals", "Bran", "Garden Refuse", "Fruit & Veggie"]
    //var horse = viewModel.horses[0]
    //let formatter1 = DateFormatter()
    @State var url = ""
    @State private var showPopUp: Bool = false
    
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(){
                    VStack {
                        if url != ""{
                            AsyncImage(
                               url: URL(string: url)!,
                                placeholder: { Color.black},
                               image: { Image(uiImage: $0).resizable() }
                            ).clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                        } else {
                            Image(systemName: "photo")
                        }
                        

//                            //AnimatedImage(url:URL(string: url)!).resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
//                        }
//                        else{
//
//                            Loader()
//                        }
                    }
                    .onAppear() {
                        let storage = Storage.storage().reference()
                        storage.child(id).listAll{ (result, error) in
                            if let error = error {
                                print("an error has occured - \(error.localizedDescription)")
                            }
                            if result.items == [] {
                                storage.child("Default_Pictures/Horse.png").downloadURL { (url, err) in
                                    if err != nil{

                                        print((err?.localizedDescription)!)
                                        return
                                    }

                                    self.url = "\(url!)"
                                    print(self.url)
                                }
                            } else {
                                storage.child("\(id)/\(id)").downloadURL { (url, err) in
                                    if err != nil{

                                        print((err?.localizedDescription)!)
                                        return
                                    }

                                    self.url = "\(url!)"
                                    print(self.url)
                                }
                            }
                        }
                        
                    }
                    Text(viewModel.horse.name).fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                    
                    HStack(spacing: UIScreen.main.bounds.width*0.02) {
                        NavigationLink(destination: EditProfileView(id: id, prevOwner: viewModel.horse.owner, horse: viewModel.horse)) {
                            Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(.lightGray)).opacity(0.7).cornerRadius(16)
                    
                        Button(action:{
                            //presentationMode.wrappedValue.dismiss()
                            showPopUp.toggle()
                        }) {
                            Text("Delete Profile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(.white)
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(.red)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
                    }.padding(UIScreen.main.bounds.height*0.005)
                    
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                        Text("Date of Birth: " + date_to_string(d: viewModel.horse.birth)).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Gender: " + genderChoices[viewModel.horse.gender]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Color: " + colorChoices[viewModel.horse.color]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Height: " + heightChoices[viewModel.horse.height]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Owner: " + viewModel.horse.ownerName).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Arrival Date: " + date_to_string(d: viewModel.horse.arrivalDate)).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Feed: " + feedChoices[viewModel.horse.feed]).font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.padding(UIScreen.main.bounds.height*0.005)
                
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                        Button(action: {
                            print("Going to upcoming Training Rides")
                        }) {
                            Text("Upcoming Training Rides").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                        NavigationLink(destination: NewRiderProfileView(id:viewModel.horse.owner)) {
                            Text("Rider Profiles").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.disabled(viewModel.horse.owner == "").frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                    }.padding(UIScreen.main.bounds.height*0.005)
                }
                .padding(EdgeInsets(top: UIScreen.main.bounds.height*0.05, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Horse Profile", displayMode: .inline)
                
                PopUpWindow(title: "Notice", message: "Sure about deleting this?", buttonText1: "Yes", buttonText2: "No", horse: viewModel.horse, show: $showPopUp)
            }
        }.onAppear() {
            self.viewModel.fetchData(id: id)
        }
        MenuView()
    }
    
    func date_to_string(d:Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: d)
    }
}

struct NewRiderProfileView: View {
//    @State private var editProfile = false
//    var horse = Horse(DOB: "2021", height: 16, horseID: 1, name: "Haha", weight: 200)
    var id: String
    
    @ObservedObject private var viewModel = RiderViewModel()
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = ["5", "10", "15", "20", "25", "30"]
    //var horse = viewModel.horses[0]
    //let formatter1 = DateFormatter()
    @State var url = ""
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ScrollView{
            ZStack {
                VStack(){
                    VStack {
                        if url != ""{
                            AsyncImage(
                               url: URL(string: url)!,
                                placeholder: { Color.black},
                               image: { Image(uiImage: $0).resizable() }
                            ).clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                        } else {
                            Image(systemName: "photo")
                        }
                        
//                        if url != ""{
//
//                            AnimatedImage(url:URL(string: url)!).resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
//                        }
//                        else{
//
//                            Loader()
//                        }
                    }
                    .onAppear() {
                        let storage = Storage.storage().reference()
                        storage.child(id).listAll{ (result, error) in
                            if let error = error {
                                print("an error has occured - \(error.localizedDescription)")
                            }
                            if result.items == [] {
                                storage.child("Default_Pictures/Rider.png").downloadURL { (url, err) in
                                    if err != nil{

                                        print((err?.localizedDescription)!)
                                        return
                                    }

                                    self.url = "\(url!)"
                                    print(self.url)
                                }
                            } else {
                                storage.child("\(id)/\(id)").downloadURL { (url, err) in
                                    if err != nil{

                                        print((err?.localizedDescription)!)
                                        return
                                    }

                                    self.url = "\(url!)"
                                    print(self.url)
                                }
                            }
                        }
                    }
                    Text(viewModel.rider.name).fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                    
                    HStack(spacing: UIScreen.main.bounds.width*0.02) {
                        NavigationLink(destination: EditRiderProfileView(id: id, prevHorse: viewModel.rider.horse, prevInstructor: viewModel.rider.instructor, rider: viewModel.rider)) {
                            Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(.lightGray)).opacity(0.7).cornerRadius(16)
                    
                        Button(action:{
                            //presentationMode.wrappedValue.dismiss()
                            showPopUp.toggle()
                        }) {
                            Text("Delete Profile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(.white)
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(.red)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
                    }.padding(UIScreen.main.bounds.height*0.005)
                    
                
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                        Text("Joined Date: " + date_to_string(d: viewModel.rider.joinedDate)).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Age: " + ageChoices[viewModel.rider.age]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Gender: " + genderChoices[viewModel.rider.gender]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Height: " + heightChoices[viewModel.rider.height]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Owned Horse: " + viewModel.rider.horseName).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Instructor: " + viewModel.rider.instructorName).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Email: " + viewModel.rider.email).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Phone: " + viewModel.rider.phone).font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.padding(UIScreen.main.bounds.height*0.005)
                
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                        Button(action: {
                            print("Going to upcoming Training Rides")
                        }) {
                            Text("Upcoming Training Rides").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                        NavigationLink(destination: NewProfileView(id: viewModel.rider.horse)) {
                            Text("Horse Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.disabled(viewModel.rider.horse == "").frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                        NavigationLink(destination: NewInstructorProfileView(id: viewModel.rider.instructor)) {
                            Text("Instructor Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.disabled(viewModel.rider.instructor == "").frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                    }.padding(UIScreen.main.bounds.height*0.005)
                }
                .padding(EdgeInsets(top: UIScreen.main.bounds.height*0.05, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Rider Profile", displayMode: .inline)
                PopUpWindowforRider(title: "Notice", message: "Sure about deleting this?", buttonText1: "Yes", buttonText2: "No", rider: viewModel.rider, show: $showPopUp).zIndex(11)
            }
        }.onAppear() {
            self.viewModel.fetchData(id: id)
        }
        MenuView()
    }
    
    func date_to_string(d:Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: d)
    }
}

struct NewInstructorProfileView: View {
//    @State private var editProfile = false
//    var horse = Horse(DOB: "2021", height: 16, horseID: 1, name: "Haha", weight: 200)
    var id: String
    
    @ObservedObject private var viewModel = InstructorViewModel()
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = ["5", "10", "15", "20", "25", "30"]
    //var horse = viewModel.horses[0]
    //let formatter1 = DateFormatter()
    @State var url = ""
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ScrollView{
            ZStack {
                VStack(){
                    VStack {
                        if url != ""{
                            AsyncImage(
                               url: URL(string: url)!,
                                placeholder: { Color.black},
                               image: { Image(uiImage: $0).resizable() }
                            ).clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                        } else {
                            Image(systemName: "photo")
                        }
                        
//                        if url != ""{
//
//                            AnimatedImage(url:URL(string: url)!).resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
//                        }
//                        else{
//                            
//                            Loader()
//                        }
                    }
                    .onAppear() {
                        let storage = Storage.storage().reference()
                        storage.child(id).listAll{ (result, error) in
                            if let error = error {
                                print("an error has occured - \(error.localizedDescription)")
                            }
                            if result.items == [] {
                                storage.child("Default_Pictures/Instructor.png").downloadURL { (url, err) in
                                    if err != nil{

                                        print((err?.localizedDescription)!)
                                        return
                                    }

                                    self.url = "\(url!)"
                                    print(self.url)
                                }
                            } else {
                                storage.child("\(id)/\(id)").downloadURL { (url, err) in
                                    if err != nil{

                                        print((err?.localizedDescription)!)
                                        return
                                    }

                                    self.url = "\(url!)"
                                    print(self.url)
                                }
                            }
                        }
                    }
                    Text(viewModel.instructor.name).fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                    
                    HStack(spacing: UIScreen.main.bounds.width*0.02) {
                        NavigationLink(destination: EditInstructorProfileView(id: id, prevStudent: viewModel.instructor.student, instructor: viewModel.instructor)) {
                            Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(.lightGray)).opacity(0.7).cornerRadius(16)
                    
                        Button(action:{
                            //presentationMode.wrappedValue.dismiss()
                            showPopUp.toggle()
                        }) {
                            Text("Delete Profile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(.white)
                        }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(.red)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
                    }.padding(UIScreen.main.bounds.height*0.005)
                
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                        Text("Joined Date: " + date_to_string(d: viewModel.instructor.joinedDate)).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Age: " + ageChoices[viewModel.instructor.age]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Gender: " + genderChoices[viewModel.instructor.gender]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Height: " + heightChoices[viewModel.instructor.height]).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Student: " + viewModel.instructor.studentName).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Email: " + viewModel.instructor.email).font(.system(size:UIScreen.main.bounds.height*0.025))
                        Text("Phone: " + viewModel.instructor.phone).font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.padding(UIScreen.main.bounds.height*0.005)
                
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                        Button(action: {
                            print("Going to upcoming Training Rides")
                        }) {
                            Text("Upcoming Training Rides").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                        NavigationLink(destination: NewRiderProfileView(id: viewModel.instructor.student)) {
                            Text("Student Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                        }.disabled(viewModel.instructor.student == "").frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                    }.padding(UIScreen.main.bounds.height*0.005)
                }
                .padding(EdgeInsets(top: UIScreen.main.bounds.height*0.05, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Instructor Profile", displayMode: .inline)
                PopUpWindowforInstructor(title: "Notice", message: "Sure about deleting this?", buttonText1: "Yes", buttonText2: "No", instructor: viewModel.instructor, show: $showPopUp)
            }
        }.onAppear() {
            self.viewModel.fetchData(id: id)
        }
        MenuView()
    }
    
    func date_to_string(d:Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: d)
    }
}

struct Loader: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}



//struct NewProfileView_Previews: PreviewProvider {
//    @State var showup: Bool = false
//    static var previews: some View {
//        NewProfileView(id:"Horse1", showup: $showup)
//            .preferredColorScheme(.light)
//    }
//}
