//
//  editProfile.swift
//  TACKtical
//
//
import SwiftUI
import Firebase
import FirebaseStorage

struct EditProfileView: View {
    var id: String
    @State var horse: Horse
    @ObservedObject private var viewModel = HorseViewModel()
    @ObservedObject private var viewModel2 = RiderViewModel()
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var genderChoices = ["Male", "Female"]
    var colorChoices = ["Bay", "Chestnut", "Gray", "Dun"]
    var heightChoices = ["10", "11", "12", "13", "14", "15", "16"]
    var feedChoices = ["Pasture Grass", "Hay", "Grains", "Salt & Minerals", "Bran", "Garden Refuse", "Fruit & Veggie"]
    
    
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
                    TextField("Enter new name", text: $horse.name)
                }
                Picker(selection: $horse.gender, label: Text("Gender")) {
                    ForEach(0 ..< genderChoices.count) {
                        Text(self.genderChoices[$0])
                    }
                }
                Picker(selection: $horse.color, label: Text("Color")) {
                    ForEach(0 ..< colorChoices.count) {
                        Text(self.colorChoices[$0])
                    }
                }
                Picker(selection: $horse.height, label: Text("Height")) {
                    ForEach(0 ..< heightChoices.count) {
                        Text(self.heightChoices[$0])
                    }
                }
                Picker(selection: $horse.feed, label: Text("Feed")) {
                    ForEach(0 ..< feedChoices.count) {
                        Text(self.feedChoices[$0])
                    }
                }
                
                DatePicker(selection: $horse.birth, in: ...Date(), displayedComponents: .date) {
                    Text("Birth Date")
                }
                
                DatePicker(selection: $horse.arrivalDate, in: ...Date(), displayedComponents: .date) {
                    Text("Arrival Date")
                }
                
                ZStack(alignment: .top) {
                    CustomRiderSearchBar(riders: self.$viewModel2.riders, rider: $horse.owner, riderName: $horse.ownerName, txt: horse.ownerName).padding(.top)
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
            
            Button(action: {upload()}){
                Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
//            NavigationLink(destination: NewProfileView(id:id)) {
//                Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
//            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Edit Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("HorseProfiles").document(id).setData(["Arrival Date": formatter1.string(from: horse.arrivalDate), "Color": horse.color, "Date of Birth": formatter1.string(from: horse.birth), "Feed": horse.feed, "Gender": horse.gender, "Height": horse.height, "Owner": horse.owner, "name":horse.name, "Owner Name": horse.ownerName], merge:true)
        if horse.owner != ""{
            db.collection("RiderProfiles").document(horse.owner).updateData(["Owned Horse": id, "Horse Name": horse.name])
        }
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

struct EditRiderProfileView: View {
    var id: String
    @State var rider: Rider
    @State var prevOwner: String = ""
    @ObservedObject private var viewModel = RiderViewModel()
    @ObservedObject private var viewModel2 = HorseViewModel()
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = ["5", "10", "15", "20", "25", "30"]
    
    
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
                    TextField("Enter name", text: $rider.name)
                }
                Picker(selection: $rider.gender, label: Text("Gender")) {
                    ForEach(0 ..< genderChoices.count) {
                        Text(self.genderChoices[$0])
                    }
                }
                Picker(selection: $rider.age, label: Text("Age")) {
                    ForEach(0 ..< ageChoices.count) {
                        Text(self.ageChoices[$0])
                    }
                }
                Picker(selection: $rider.height, label: Text("Height")) {
                    ForEach(0 ..< heightChoices.count) {
                        Text(self.heightChoices[$0])
                    }
                }
                
                HStack() {
                    Text("Email ").foregroundColor(.black)
                    TextField("Enter email address", text: $rider.email)
                }
                
                HStack() {
                    Text("Phone ").foregroundColor(.black)
                    TextField("Enter phone number", text: $rider.phone)
                }
                
                DatePicker(selection: $rider.joinedDate, in: ...Date(), displayedComponents: .date) {
                    Text("Birth Date")
                }
                
                ZStack(alignment: .top) {
                    CustomHorseSearchBar(horses: self.$viewModel2.horses, horse: $rider.horse, horseName: $rider.horseName, prevOwner: $prevOwner, txt: rider.horseName).padding(.top)
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
            
            Button(action: {upload()}){
                Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
//            NavigationLink(destination: NewProfileView(id:id)) {
//                Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
//            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Edit Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("RiderProfiles").document(id).setData(["Age": rider.age, "Email": rider.email, "Gender": rider.gender, "Height": rider.height, "ID": rider.id, "Joined Date": formatter1.string(from: rider.joinedDate), "Owned Horse": rider.horse, "Phone": rider.phone, "name":rider.name, "Horse Name":rider.horseName], merge:true)
        if rider.horse != ""{
            db.collection("HorseProfiles").document(rider.horse).updateData(["Owner": id, "Owner Name": rider.name])
        }
        
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

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView(id:"Horse1")
//    }
//}
