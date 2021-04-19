//
//  CreateProfileView.swift
//  TACKtical
//
//
import SwiftUI
import Firebase

struct CreateProfileView: View {
    
    var body: some View {
        var horseID = UUID().uuidString
        var riderID = UUID().uuidString
        VStack() {
            NavigationLink(destination: CreateHorseProfileView(id: horseID)) {
                Text("Create a Horse Profile")
            }
            NavigationLink(destination: CreateRiderProfileView(id: riderID)) {
                Text("Create a Rider Profile")
            }
            NavigationLink(destination: CreateHorseProfileView(id: horseID)) {
                Text("Create an Instructor Profile")
            }
        }
    }
    
}

struct CreateHorseProfileView: View {
    @ObservedObject private var viewModel = HorseViewModel()
    @ObservedObject private var viewModel2 = RiderViewModel()
    var id: String
    @State var name: String = ""
    @State var birth = Date()
    @State var gender: Int = 0
    @State var color: Int = 0
    @State var height: Int = 0
    @State var owner: String = ""
    @State var arrival = Date()
    @State var feed : Int = 0
    @State var ownerName: String = ""
    var genderChoices = ["Male", "Female"]
    var colorChoices = ["Bay", "Chestnut", "Gray", "Dun"]
    var heightChoices = ["10", "11", "12", "13", "14", "15", "16"]
    var feedChoices = ["Pasture Grass", "Hay", "Grains", "Salt & Minerals", "Bran", "Garden Refuse", "Fruit & Veggie"]
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var body: some View {
        Form {
            Section {
                
                HStack() {
                    Text("Picture").foregroundColor(.black)
                    if upload_image != nil {
                        Image(uiImage: upload_image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:30, height:30)
                    } else {
                        Image(systemName: "timelapse")
                        .resizable()
                        .scaledToFit()
                        .frame(width:30, height:30)
                    }
                    Button(action: {self.showActionSheet = true}) {
                        Text("Choose Image")
                    }.actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Add a picture to the profile"), message: nil, buttons: [
                    //Button1
                    .default(Text("Camera"), action: {
                        self.showImagePicker = true
                        self.sourceType = .camera
                    }),
                    //Button2
                    .default(Text("Photo Library"), action: {
                        self.showImagePicker = true
                        self.sourceType = .photoLibrary
                    }),
                                        
                    //Button3
                    .cancel()
                                        
                    ])
                    }.sheet(isPresented: $showImagePicker){
                        imagePicker(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                                    
                    }
                }
                HStack() {
                    Text("Name ").foregroundColor(.black)
                    Spacer()
                    TextField("Enter name", text: $name)
                }
                Picker(selection: $gender, label: Text("Gender")) {
                    ForEach(0 ..< genderChoices.count) {
                        Text(self.genderChoices[$0])
                    }
                }
                Picker(selection: $color, label: Text("Color")) {
                    ForEach(0 ..< colorChoices.count) {
                        Text(self.colorChoices[$0])
                    }
                }
                Picker(selection: $height, label: Text("Height")) {
                    ForEach(0 ..< heightChoices.count) {
                        Text(self.heightChoices[$0])
                    }
                }
                Picker(selection: $feed, label: Text("Feed")) {
                    ForEach(0 ..< feedChoices.count) {
                        Text(self.feedChoices[$0])
                    }
                }
                
                DatePicker(selection: $birth, in: ...Date(), displayedComponents: .date) {
                    Text("Birth Date")
                }
                
                DatePicker(selection: $arrival, in: ...Date(), displayedComponents: .date) {
                    Text("Arrival Date")
                }
                
                ZStack(alignment: .top) {
                    CustomRiderSearchBar(riders: self.$viewModel2.riders, rider: $owner, riderName: $ownerName, txt: "").padding(.top)
                }.onAppear() {
                    self.viewModel2.fetchAllData()
                }
            }
        }
        VStack {
            Button(action: {
                if let thisImage = self.upload_image {
                    uploadImage(image: thisImage)
                }else{
                    print("couldn't upload image - no image present")
                }}) {
                Text("Upload Image").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
            Button(action: {
                    let storage = Storage.storage()
                    storage.reference().child(id).listAll{ (result, error) in
                        if let error = error {
                            print("an error has occured - \(error.localizedDescription)")
                        }
                        print(result.items)
                        if result.items == [] {
                            uploadImage(image: UIImage(imageLiteralResourceName: "Horse"))
                        }
                    }
                    upload()}){
                Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
//            VStack{
//                Button(action: {upload()}){
//                    Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
//                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
//            }
            NavigationLink(destination: NewProfileView(id: id)) {
                Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Create Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        print(id)
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("HorseProfiles").document(id).setData(["Arrival Date": formatter1.string(from: arrival), "Color": color, "Date of Birth": formatter1.string(from: birth), "Feed": feed, "Gender": gender, "Height": height, "ID": id, "Owner": owner, "name":name, "Owner Name":ownerName], merge:true)
    }
    
    func uploadImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            let storage = Storage.storage()
            storage.reference().child("\(id)/\(id)").putData(imageData, metadata: nil){
                (_, err) in
                if let err = err {
                    print("an error has occured - \(err.localizedDescription)")
                } else {
                    print("image uploaded successfully")
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
}

struct CreateRiderProfileView: View {
    @ObservedObject private var viewModel = RiderViewModel()
    @ObservedObject private var viewModel2 = HorseViewModel()
    var id: String
    @State var name: String = ""
    @State var joinedDate = Date()
    @State var gender: Int = 0
    @State var height: Int = 0
    @State var age: Int = 0
    @State var horse: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var horseName: String = ""
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = ["5", "10", "15", "20", "25", "30"]
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var body: some View {
        Form {
            Section {
                
                HStack() {
                    Text("Picture").foregroundColor(.black)
                    if upload_image != nil {
                        Image(uiImage: upload_image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:30, height:30)
                    } else {
                        Image(systemName: "timelapse")
                        .resizable()
                        .scaledToFit()
                        .frame(width:30, height:30)
                    }
                    Button(action: {self.showActionSheet = true}) {
                        Text("Choose Image")
                    }.actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Add a picture to the profile"), message: nil, buttons: [
                    //Button1
                    .default(Text("Camera"), action: {
                        self.showImagePicker = true
                        self.sourceType = .camera
                    }),
                    //Button2
                    .default(Text("Photo Library"), action: {
                        self.showImagePicker = true
                        self.sourceType = .photoLibrary
                    }),
                                        
                    //Button3
                    .cancel()
                                        
                    ])
                    }.sheet(isPresented: $showImagePicker){
                        imagePicker(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                                    
                    }
                }
                HStack() {
                    Text("Name ").foregroundColor(.black)
                    Spacer()
                    TextField("Enter name", text: $name)
                }
                Picker(selection: $gender, label: Text("Gender")) {
                    ForEach(0 ..< genderChoices.count) {
                        Text(self.genderChoices[$0])
                    }
                }
                Picker(selection: $age, label: Text("Age")) {
                    ForEach(0 ..< ageChoices.count) {
                        Text(self.ageChoices[$0])
                    }
                }
                Picker(selection: $height, label: Text("Height")) {
                    ForEach(0 ..< heightChoices.count) {
                        Text(self.heightChoices[$0])
                    }
                }
                
                HStack() {
                    Text("Email ").foregroundColor(.black)
                    TextField("Enter email address", text: $email)
                }
                
                HStack() {
                    Text("Phone ").foregroundColor(.black)
                    TextField("Enter phone number", text: $phone)
                }
                
                DatePicker(selection: $joinedDate, in: ...Date(), displayedComponents: .date) {
                    Text("Joined Date")
                }
                
                
                ZStack(alignment: .top) {
                    CustomHorseSearchBar(horses: self.$viewModel2.horses, horse: $horse, horseName: $horseName, txt: "").padding(.top)
                }.onAppear() {
                    self.viewModel2.fetchAllData()
                }
                
            }
        }
        VStack {
            Button(action: {
                if let thisImage = self.upload_image {
                    uploadImage(image: thisImage)
                }else{
                    print("couldn't upload image - no image present")
                }}) {
                Text("Upload Image").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
            Button(action: {
                    let storage = Storage.storage()
                    storage.reference().child(id).listAll{ (result, error) in
                        if let error = error {
                            print("an error has occured - \(error.localizedDescription)")
                        }
                        print(result.items)
                        if result.items == [] {
                            uploadImage(image: UIImage(imageLiteralResourceName: "Lebron"))
                        }
                    }
                    upload()}){
                Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
//            VStack{
//                Button(action: {upload()}){
//                    Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
//                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
//            }
            NavigationLink(destination: NewRiderProfileView(id: id)) {
                Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Create Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        print(id)
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("RiderProfiles").document(id).setData(["Age": age, "Email": email, "Gender": gender, "Height": height, "ID": id, "Joined Date": formatter1.string(from: joinedDate), "Owned Horse": horse, "Phone": phone, "name":name, "Horse Name": horseName], merge:true)
    }
    
    func uploadImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            let storage = Storage.storage()
            storage.reference().child("\(id)/\(id)").putData(imageData, metadata: nil){
                (_, err) in
                if let err = err {
                    print("an error has occured - \(err.localizedDescription)")
                } else {
                    print("image uploaded successfully")
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}

struct CustomHorseSearchBar: View {
    
    @Binding var horses: [Horse]
    @Binding var horse: String
    @Binding var horseName: String
    @State var txt: String
    
    var body: some View{
        
        VStack{
            HStack{
                Text("Horse")
                TextField("Search for horses", text:self.$txt)
                
                if self.txt != ""{
                    Button(action: {
                        self.txt = ""
                    }){
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                }
                
            }
            
            if self.txt != ""{
                List(self.horses.filter{$0.name.lowercased().contains(self.txt.lowercased())}){ i in
                    Button(action: {
                        horse = i.id
                        horseName = i.name
                        self.txt = i.name
                    }) {
                        Text(i.name)
                    }
                }
            }
        }
    }
}

struct CustomRiderSearchBar: View {
    
    @Binding var riders: [Rider]
    @Binding var rider: String
    @Binding var riderName: String
    @State var txt: String
    
    var body: some View{
        
        VStack{
            HStack{
                Text("Owner")
                TextField("Search for owners", text:self.$txt)
                
                if self.txt != ""{
                    Button(action: {
                        self.txt = ""
                    }){
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                }
                
            }
            
            if self.txt != ""{
                List(self.riders.filter{$0.name.lowercased().contains(self.txt.lowercased())}){ i in
                    Button(action: {
                        rider = i.id
                        riderName = i.name
                        self.txt = i.name
                    }) {
                        Text(i.name)
                    }
                }
            }
        }
    }
}
