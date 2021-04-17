//
//  CreateProfileView.swift
//  TACKtical
//
//
import SwiftUI
import Firebase

struct CreateProfileView: View {
    @ObservedObject private var viewModel = HorseViewModel()
    var id: String
    @State var name: String = ""
    @State var birth = Date()
    @State var gender: Int = 0
    @State var color: Int = 0
    @State var height: Int = 0
    @State var owner: String = ""
    @State var arrival = Date()
    @State var feed : Int = 0
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
                HStack() {
                    Text("Owner ").foregroundColor(.black)
                    TextField("Enter owner name", text: $owner)
                }
                
                DatePicker(selection: $birth, in: ...Date(), displayedComponents: .date) {
                    Text("Birth Date")
                }
                
                DatePicker(selection: $arrival, in: ...Date(), displayedComponents: .date) {
                    Text("Arrival Date")
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
        
        db.collection("HorseProfiles").document(id).setData(["Arrival Date": formatter1.string(from: arrival), "Color": color, "Date of Birth": formatter1.string(from: birth), "Feed": feed, "Gender": gender, "Height": height, "ID": id, "Owner": owner, "name":name], merge:true)
    }
    
    func uploadImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            let storage = Storage.storage()
            storage.reference().child(id).putData(imageData, metadata: nil){
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
        CreateProfileView(id: "Horse1")
    }
}
