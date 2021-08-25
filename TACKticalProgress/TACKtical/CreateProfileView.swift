//
//  CreateProfileView.swift
//  TACKtical
//
//
import SwiftUI
import Firebase

struct CreateHorseProfileView: View {
    @ObservedObject private var viewModel = HorseViewModel()
    @ObservedObject private var viewModel2 = RiderViewModel()
    let id: String
    @State var newid: String = ""
    @State var name: String = ""
    @State var birth = Date()
    @State var gender: Int = 0
    @State var color: Int = 0
    @State var height: Int = 0
    @State var owner: String = ""
    @State var arrival = Date()
    @State var feed : Int = 0
    @State var ownerName: String = ""
    @State var prevInstructor: String = ""
    @State var prevHorse: String = ""
    var genderChoices = ["Male", "Female"]
    var colorChoices = ["Bay", "Chestnut", "Gray", "Dun"]
    var heightChoices = ["10", "11", "12", "13", "14", "15", "16"]
    var feedChoices = ["Pasture Grass", "Hay", "Grains", "Salt & Minerals", "Bran", "Garden Refuse", "Fruit & Veggie"]
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    @State private var showNewProfileButton: Bool = false
    @State private var uploadedOtherData: Bool = false
    @State private var uploadedImage: Bool = true
    @State private var finishUploadingImage: Bool = false
    @State private var uploadingImage: Bool = false
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
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
                        Text("Choose").foregroundColor(.blue).onTapGesture {
                            self.newid = id
                            self.showActionSheet = true
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
                        
                        Text("Upload").foregroundColor(.blue).onTapGesture{
                            if let thisImage = self.upload_image {
                                self.showNewProfileButton = false
                                self.uploadedImage = false
                                self.finishUploadingImage = false
                                self.uploadingImage = true
                                uploadImage(image: thisImage)
                            }else{
                                print("couldn't upload image - no image present")
                            }
                        }
                        
                        if finishUploadingImage{
                            Text("Done").foregroundColor(.green)
                        } else if uploadingImage{
                            Text("ing").foregroundColor(.gray)
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
                        CustomRiderSearchBar(riders: self.viewModel2.riders, rider: $owner, riderName: $ownerName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: "").padding(.top)
                    }.onAppear() {
                        self.viewModel2.fetchAllData()
                    }
                }
            }
            GeneralPopUpWindow(title: "Notice", message: "Profile Created!", buttonText: "OK", show: $showPopUp)
        }
        VStack {
            
            Button(action: {
                upload()
                if uploadedImage {
                    self.showNewProfileButton = true
                }
                self.uploadedOtherData = true
            }){
                Text("Upload Info").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
//            VStack{
//                Button(action: {upload()}){
//                    Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
//                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
//            }
            if showNewProfileButton {
                NavigationLink(destination: NewProfileView(id: id)) {
                    Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.simultaneousGesture(TapGesture().onEnded{print(id+"777777")}).frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            }
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Create Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        print(id + "9999")
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("HorseProfiles").document(id).setData(["Arrival Date": formatter1.string(from: arrival), "Color": color, "Date of Birth": formatter1.string(from: birth), "Feed": feed, "Gender": gender, "Height": height, "ID": id, "Owner": owner, "name":name, "Owner Name":ownerName], merge:true)
        if owner != ""{
            if prevHorse != ""{
                print(prevHorse)
                db.collection("HorseProfiles").document(prevHorse).updateData(["Owner": "", "Owner Name": ""])
            }
            db.collection("RiderProfiles").document(owner).updateData(["Owned Horse": id, "Horse Name": name])
        }
        self.showPopUp.toggle()
    }
    
    func uploadImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            let storage = Storage.storage()
            print(id + "9999")
            storage.reference().child("\(id)/\(id)").putData(imageData, metadata: nil){
                (_, err) in
                if let err = err {
                    print("an error has occured - \(err.localizedDescription)")
                } else {
                    print("image uploaded successfully")
                    if self.uploadedOtherData {
                        self.showNewProfileButton = true
                    }
                    self.uploadedImage = true
                    self.finishUploadingImage = true
                    self.uploadingImage = false
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
    @ObservedObject private var viewModel3 = InstructorViewModel()
    let id: String
    @State var name: String = ""
    @State var joinedDate = Date()
    @State var gender: Int = 0
    @State var height: Int = 0
    @State var age: Int = 0
    @State var horse: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var horseName: String = ""
    @State var instructor: String = ""
    @State var instructorName: String = ""
    @State var prevOwner: String = ""
    @State var prevStudent: String = ""
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "4.10", "4.11", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10", "5.11", "6.0", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = [Int](15...60)
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    @State private var showNewProfileButton: Bool = false
    @State private var uploadedOtherData: Bool = false
    @State private var uploadedImage: Bool = true
    @State private var finishUploadingImage: Bool = false
    @State private var uploadingImage: Bool = false
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
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
                        Text("Choose").foregroundColor(.blue).onTapGesture {
                            self.showActionSheet = true
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
                        
                        Text("Upload").foregroundColor(.blue).onTapGesture{
                            if let thisImage = self.upload_image {
                                self.showNewProfileButton = false
                                self.uploadedImage = false
                                self.finishUploadingImage = false
                                self.uploadingImage = true
                                uploadImage(image: thisImage)
                            }else{
                                print("couldn't upload image - no image present")
                            }
                        }
                        
                        if finishUploadingImage{
                            Text("Done").foregroundColor(.green)
                        } else if uploadingImage{
                            Text("ing").foregroundColor(.gray)
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
                            Text(String(self.ageChoices[$0]))
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
                        CustomHorseSearchBar(horses: self.$viewModel2.horses, horse: $horse, horseName: $horseName, prevOwner: $prevOwner, txt: "").padding(.top)
                    }.onAppear() {
                        self.viewModel2.fetchAllData()
                    }
                    
                    ZStack(alignment: .top) {
                        CustomInstructorSearchBar(instructors: self.$viewModel3.instructors, instructor: $instructor, instructorName: $instructorName, prevStudent: $prevStudent, txt: "").padding(.top)
                    }.onAppear() {
                        self.viewModel3.fetchAllData()
                    }
                    
                }
            }
            GeneralPopUpWindow(title: "Notice", message: "Profile Created!", buttonText: "OK", show: $showPopUp)
        }
        VStack {
            
            Button(action: {
                upload()
                if uploadedImage {
                    self.showNewProfileButton = true
                }
                self.uploadedOtherData = true
            }){
                Text("Upload Info").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
            if showNewProfileButton{
                NavigationLink(destination: NewRiderProfileView(id: id)) {
                    Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            }
            
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Create Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        print(id)
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("RiderProfiles").document(id).setData(["Age": age, "Email": email, "Gender": gender, "Height": height, "ID": id, "Joined Date": formatter1.string(from: joinedDate), "Owned Horse": horse, "Phone": phone, "name":name, "Horse Name": horseName, "Instructor": instructor, "Instructor Name": instructorName], merge:true)
        if horse != ""{
            //db.collection("RiderProfiles").document(id).collection("Horses").document(horse).setData(["Horse Name": horseName], merge: true)
            if prevOwner != ""{
                print(prevOwner)
                db.collection("RiderProfiles").document(prevOwner).updateData(["Owned Horse": "", "Horse Name": ""])
            }
            
            db.collection("HorseProfiles").document(horse).updateData(["Owner": id, "Owner Name": name])
        }
        
        if instructor != ""{
            if prevStudent != ""{
                print(prevStudent)
                db.collection("RiderProfiles").document(prevStudent).updateData(["Instructor": "", "Instructor Name": ""])
            }
            
            db.collection("InstructorProfiles").document(instructor).updateData(["Student": id, "Student Name": name])
        }
        self.showPopUp.toggle()
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
                    if self.uploadedOtherData {
                        self.showNewProfileButton = true
                    }
                    self.uploadedImage = true
                    self.finishUploadingImage = true
                    self.uploadingImage = false
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
}

struct CreateInstructorProfileView: View {
    @ObservedObject private var viewModel = InstructorViewModel()
    @ObservedObject private var viewModel2 = RiderViewModel()
    let id: String
    @State var newid: String = ""
    @State var name: String = ""
    @State var joinedDate = Date()
    @State var gender: Int = 0
    @State var height: Int = 0
    @State var age: Int = 0
    @State var student: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var studentName: String = ""
    @State var prevInstructor: String = ""
    @State var prevHorse: String = ""
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "4.10", "4.11", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10", "5.11", "6.0", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = [Int](15...60)
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    @State private var showNewProfileButton: Bool = false
    @State private var uploadedOtherData: Bool = false
    @State private var uploadedImage: Bool = true
    @State private var uploadingImage: Bool = false
    @State private var finishUploadingImage: Bool = false
    @State private var showPopUp: Bool = false
    
    
    var body: some View {
        ZStack {
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
                        Text("Choose").foregroundColor(.blue).onTapGesture {
                            self.showActionSheet = true
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
                        
                        Text("Upload").foregroundColor(.blue).onTapGesture{
                            if let thisImage = self.upload_image {
                                self.showNewProfileButton = false
                                self.uploadedImage = false
                                self.uploadingImage = true
                                self.finishUploadingImage = false
                                uploadImage(image: thisImage)
                            }else{
                                print("couldn't upload image - no image present")
                            }
                        }
                        
                        if finishUploadingImage{
                            Text("Done").foregroundColor(.green)
                        } else if uploadingImage{
                            Text("ing").foregroundColor(.gray)
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
                            Text(String(self.ageChoices[$0]))
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
                        CustomRiderSearchBar(riders: self.viewModel2.riders, rider: $student, riderName: $studentName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: "").padding(.top)
                    }.onAppear() {
                        self.viewModel2.fetchAllData()
                    }.frame(maxHeight: .infinity)
                    
                }
            }
            GeneralPopUpWindow(title: "Notice", message: "Profile Created!", buttonText: "OK", show: $showPopUp)
        }
        VStack {
            
            Button(action: {
                upload()
                if uploadedImage {
                    self.showNewProfileButton = true
                }
                self.uploadedOtherData = true
            }){
                Text("Upload Info").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
            if self.showNewProfileButton {
                NavigationLink(destination: NewInstructorProfileView(id: newid)) {
                    Text("New Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            }
            
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Create Profile", displayMode: .inline)
    }
    func upload() {
        let db = Firestore.firestore()
        print(id)
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("InstructorProfiles").document(id).setData(["Age": age, "Email": email, "Gender": gender, "Height": height, "ID": id, "Joined Date": formatter1.string(from: joinedDate), "Student": student, "Phone": phone, "name":name, "Student Name": studentName], merge:true)
        self.newid = id
        if student != ""{
            //db.collection("RiderProfiles").document(id).collection("Horses").document(horse).setData(["Horse Name": horseName], merge: true)
            if prevInstructor != ""{
                print(prevInstructor)
                db.collection("InstructorProfiles").document(prevInstructor).updateData(["Student": "", "Student Name": ""])
            }
            db.collection("RiderProfiles").document(student).updateData(["Instructor": id, "Instructor Name": name])
        }
        self.showPopUp.toggle()
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
                    if self.uploadedOtherData {
                        self.showNewProfileButton = true
                    }
                    self.uploadedImage = true
                    self.finishUploadingImage = true
                    self.uploadingImage = false
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
}

struct CustomHorseSearchBar: View {
    
    @Binding var horses: [Horse]
    @Binding var horse: String
    @Binding var horseName: String
    @Binding var prevOwner: String
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
                    (Text(i.name).bold() + Text("(Horse)")).onTapGesture {
                        horse = i.id
                        horseName = i.name
                        prevOwner = i.owner
                        self.txt = i.name
                    }
                }
            }
        }
    }
}

struct CustomRiderSearchBar: View {
    
    let riders: [Rider]
    @Binding var rider: String
    @Binding var riderName: String
    @Binding var prevInstructor: String
    @Binding var prevHorse: String
    @State var txt: String
    
    var body: some View{
        
        VStack{
            HStack{
                Text("Rider")
                TextField("Search for Riders", text:self.$txt)
                
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
                    (Text(i.name).bold() + Text("(Rider)")).onTapGesture {
                        rider = i.id
                        riderName = i.name
                        prevInstructor = i.instructor
                        prevHorse = i.horse
                        self.txt = i.name
                    }
                }
            }
        }
    }
}

struct CustomInstructorSearchBar: View {
    
    @Binding var instructors: [Instructor]
    @Binding var instructor: String
    @Binding var instructorName: String
    @Binding var prevStudent: String
    @State var txt: String
    
    var body: some View{
        
        VStack{
            HStack{
                Text("Instructor")
                TextField("Search for Instructors", text:self.$txt)
                
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
                List(self.instructors.filter{$0.name.lowercased().contains(self.txt.lowercased())}){ i in
                    (Text(i.name).bold() + Text("(Instructor)")).onTapGesture {
                        instructor = i.id
                        instructorName = i.name
                        prevStudent = i.student
                        self.txt = i.name
                    }
                }
            }
        }
    }
}
