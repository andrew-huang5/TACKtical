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
    var prevOwner: String
    @State var horse: Horse
    @ObservedObject private var viewModel = HorseViewModel()
    @ObservedObject private var viewModel2 = RiderViewModel()
    
    @State var prevInstructor: String = ""
    @State var prevHorse: String = ""
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var genderChoices = ["Male", "Female"]
    var colorChoices = ["Bay", "Chestnut", "Gray", "Dun"]
    var heightChoices = ["10", "11", "12", "13", "14", "15", "16"]
    var feedChoices = ["Pasture Grass", "Hay", "Grains", "Salt & Minerals", "Bran", "Garden Refuse", "Fruit & Veggie"]
    @State private var uploadedImage: Bool = false
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
                                uploadingImage.toggle()
                                uploadedImage = false
                                uploadImage(image: thisImage)
                            }else{
                                print("couldn't upload image - no image present")
                            }
                        }
                        
                        if uploadedImage{
                            Text("Done").foregroundColor(.green)
                        } else if uploadingImage{
                            Text("ing").foregroundColor(.gray)
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
                        CustomRiderSearchBar(riders: self.viewModel2.riders, rider: $horse.owner, riderName: $horse.ownerName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: horse.ownerName).padding(.top)
                    }.onAppear() {
                        self.viewModel2.fetchAllData()
                    }
                }
            }
            GeneralPopUpWindow(title: "Notice", message: "Information uploaded!", buttonText: "OK", show: $showPopUp)
        }
        VStack {
            
            Button(action: {upload()}){
                Text("Upload Info").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Edit Profile", displayMode: .inline)
        MenuView()
    }
    func upload() {
        let db = Firestore.firestore()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("HorseProfiles").document(id).setData(["Arrival Date": formatter1.string(from: horse.arrivalDate), "Color": horse.color, "Date of Birth": formatter1.string(from: horse.birth), "Feed": horse.feed, "Gender": horse.gender, "Height": horse.height, "Owner": horse.owner, "name":horse.name, "Owner Name": horse.ownerName], merge:true)
        if horse.owner != ""{
            if prevHorse != ""{
                print(prevHorse)
                db.collection("HorseProfiles").document(prevHorse).updateData(["Owner": "", "Owner Name": ""])
            }
            if prevOwner != ""{
                db.collection("RiderProfiles").document(prevOwner).updateData(["Owned Horse": "", "Horse Name": ""])
            }
            db.collection("RiderProfiles").document(horse.owner).updateData(["Owned Horse": id, "Horse Name": horse.name])
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
                    uploadedImage.toggle()
                    uploadingImage.toggle()
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
}

struct EditRiderProfileView: View {
    var id: String
    var prevHorse: String
    var prevInstructor: String
    @State var rider: Rider
    @State var prevOwner: String = ""
    @State var prevStudent: String = ""
    @ObservedObject private var viewModel = RiderViewModel()
    @ObservedObject private var viewModel2 = HorseViewModel()
    @ObservedObject private var viewModel3 = InstructorViewModel()
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "4.10", "4.11", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10", "5.11", "6.0", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = [Int](15...60)
    @State private var uploadedImage: Bool = false
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
                                uploadingImage.toggle()
                                uploadedImage = false
                                uploadImage(image: thisImage)
                            }else{
                                print("couldn't upload image - no image present")
                            }
                        }
                        
                        if uploadedImage{
                            Text("Done").foregroundColor(.green)
                        } else if uploadingImage{
                            Text("ing").foregroundColor(.gray)
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
                            Text(String(self.ageChoices[$0]))
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
                    
                    ZStack(alignment: .top) {
                        CustomInstructorSearchBar(instructors: self.$viewModel3.instructors, instructor: $rider.instructor, instructorName: $rider.instructorName, prevStudent: $prevStudent, txt: rider.instructorName).padding(.top)
                    }.onAppear() {
                        self.viewModel3.fetchAllData()
                    }
                }
            }
            GeneralPopUpWindow(title: "Notice", message: "Information uploaded!", buttonText: "OK", show: $showPopUp)
        }
        VStack {
            
            Button(action: {upload()}){
                Text("Upload Info").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Edit Profile", displayMode: .inline)
        MenuView()
    }
    func upload() {
        let db = Firestore.firestore()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("RiderProfiles").document(id).setData(["Age": rider.age, "Email": rider.email, "Gender": rider.gender, "Height": rider.height, "ID": rider.id, "Joined Date": formatter1.string(from: rider.joinedDate), "Owned Horse": rider.horse, "Phone": rider.phone, "name":rider.name, "Horse Name":rider.horseName], merge:true)
        if rider.horse != ""{
            if prevOwner != ""{
                print(prevOwner)
                db.collection("RiderProfiles").document(prevOwner).updateData(["Owned Horse": "", "Horse Name": ""])
            }
            if prevHorse != ""{
                db.collection("HorseProfiles").document(prevHorse).updateData(["Owner": "", "Owner Name": ""])
            }
            
            db.collection("HorseProfiles").document(rider.horse).updateData(["Owner": id, "Owner Name": rider.name])
        }
        
        if rider.instructor != ""{
            if prevStudent != ""{
                print(prevStudent)
                db.collection("RiderProfiles").document(prevStudent).updateData(["Instructor": "", "Instructor Name": ""])
            }
            
            if prevInstructor != ""{
                db.collection("InstructorProfiles").document(prevInstructor).updateData(["Student": "", "Student Name": ""])
            }
            db.collection("InstructorProfiles").document(rider.instructor).updateData(["Student": id, "Student Name": rider.name])
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
                    uploadedImage.toggle()
                    uploadingImage.toggle()
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
}

struct EditInstructorProfileView: View {
    var id: String
    var prevStudent: String
    @State var instructor: Instructor
    @State var prevInstructor: String = ""
    @State var prevHorse: String = ""
    @ObservedObject private var viewModel = InstructorViewModel()
    @ObservedObject private var viewModel2 = RiderViewModel()
    
    @State var showActionSheet = false
    @State var showImagePicker = false
        
    @State var sourceType:UIImagePickerController.SourceType = .camera
        
    @State var upload_image:UIImage?
    
    var genderChoices = ["Male", "Female"]
    var heightChoices = ["4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "4.10", "4.11", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10", "5.11", "6.0", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7", "6.8", "6.9", "6.10", "6.11", "7.0"]
    var ageChoices = [Int](15...60)
    @State private var uploadedImage: Bool = false
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
                                uploadingImage.toggle()
                                uploadedImage = false
                                uploadImage(image: thisImage)
                            }else{
                                print("couldn't upload image - no image present")
                            }
                        }
                        
                        if uploadedImage{
                            Text("Done").foregroundColor(.green)
                        } else if uploadingImage{
                            Text("ing").foregroundColor(.gray)
                        }
                    }
                    HStack() {
                        Text("Name ").foregroundColor(.black)
                        Spacer()
                        TextField("Enter name", text: $instructor.name)
                    }
                    Picker(selection: $instructor.gender, label: Text("Gender")) {
                        ForEach(0 ..< genderChoices.count) {
                            Text(self.genderChoices[$0])
                        }
                    }
                    Picker(selection: $instructor.age, label: Text("Age")) {
                        ForEach(0 ..< ageChoices.count) {
                            Text(String(self.ageChoices[$0]))
                        }
                    }
                    Picker(selection: $instructor.height, label: Text("Height")) {
                        ForEach(0 ..< heightChoices.count) {
                            Text(self.heightChoices[$0])
                        }
                    }
                    
                    HStack() {
                        Text("Email ").foregroundColor(.black)
                        TextField("Enter email address", text: $instructor.email)
                    }
                    
                    HStack() {
                        Text("Phone ").foregroundColor(.black)
                        TextField("Enter phone number", text: $instructor.phone)
                    }
                    
                    DatePicker(selection: $instructor.joinedDate, in: ...Date(), displayedComponents: .date) {
                        Text("Joined Date")
                    }
                    
                    
                    ZStack(alignment: .top) {
                        CustomRiderSearchBar(riders: self.viewModel2.riders, rider: $instructor.student, riderName: $instructor.studentName, prevInstructor: $prevInstructor, prevHorse: $prevHorse, txt: instructor.studentName).padding(.top)
                    }.onAppear() {
                        self.viewModel2.fetchAllData()
                    }
                    
                }
            }
            GeneralPopUpWindow(title: "Notice", message: "Information uploaded!", buttonText: "OK", show: $showPopUp)
        }
        VStack {
            
            Button(action: {
                    let storage = Storage.storage()
                    storage.reference().child(id).listAll{ (result, error) in
                        if let error = error {
                            print("an error has occured - \(error.localizedDescription)")
                        }
                        print(result.items)
                        if result.items == [] {
                            uploadImage(image: UIImage(imageLiteralResourceName: "ClintonAnderson"))
                        }
                    }
                    upload()}){
                Text("Upload Info").font(.system(size:UIScreen.main.bounds.height*0.025))
            }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
//            VStack{
//                Button(action: {upload()}){
//                    Text("Upload").font(.system(size:UIScreen.main.bounds.height*0.025))
//                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
//            }
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).navigationBarTitle("Edit Profile", displayMode: .inline)
        MenuView()
    }
    func upload() {
        let db = Firestore.firestore()
        print(id)
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        db.collection("InstructorProfiles").document(id).setData(["Age": instructor.age, "Email": instructor.email, "Gender": instructor.gender, "Height": instructor.height, "ID": id, "Joined Date": formatter1.string(from: instructor.joinedDate), "Student": instructor.student, "Phone": instructor.phone, "name":instructor.name, "Student Name": instructor.studentName], merge:true)
        if instructor.student != ""{
            //db.collection("RiderProfiles").document(id).collection("Horses").document(horse).setData(["Horse Name": horseName], merge: true)
            if prevInstructor != ""{
                print(prevInstructor)
                db.collection("InstructorProfiles").document(prevInstructor).updateData(["Student": "", "Student Name": ""])
            }
            if prevStudent != ""{
                db.collection("RiderProfiles").document(prevStudent).updateData(["Instructor": "", "Instructor Name": ""])
            }
            db.collection("RiderProfiles").document(instructor.student).updateData(["Instructor": id, "Instructor Name": instructor.name])
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
                    uploadedImage.toggle()
                    uploadingImage.toggle()
                }
            }
            
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
}

struct GeneralPopUpWindow: View {
    var title: String
    var message: String
    var buttonText: String
    @Binding var show: Bool

    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(red: 173/255, green: 216/255, blue: 230/255, opacity: 1.0))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    HStack() {
                        
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(red: 173/255, green: 216/255, blue: 230/255, opacity: 1.0))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(red: 138/255, green: 199/255, blue: 222/255, opacity: 1.0))
            }
        }
    }
}
