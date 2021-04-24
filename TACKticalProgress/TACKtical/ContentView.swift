//
//  ContentView.swift
//  TACKtical
//
//  Created by Andrew Huang on 3/28/21.
//
import SwiftUI


//struct ContentView: View {
//    var body: some View {
        
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.light)
//    }
//}


import Firebase

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    @StateObject var model = ModelData()
    
    var body: some View {
        
        ZStack{
            
            if status{
                
                NavigationView{
                    HomeView()
                }.onAppear() {
                    UINavigationBar.appearance().backgroundColor = UIColor(red: 102/255, green: 172/255, blue: 189/255, alpha:1)
                }
                
                
            }
            else{
                
                LoginView(model:model)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginView: View {
    
    @StateObject var model = ModelData()
    
    var body: some View{
        
        ZStack{
            VStack{
                Spacer(minLength: 0)
                ZStack{
                    if UIScreen.main.bounds.height < 750{
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 130)
                    }
                    else{
                        Image("logo")
                    }
                }
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                .padding(.top)
                
                VStack(spacing: 4){
                    HStack(spacing: 0){
                        Text("TACKtical")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    Text("A barn management application for the equestrian professional")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email)
                    
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password)
                }
                .padding(.top)
                
                Button(action: model.login){
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top,22)
                
                HStack(spacing: 12){
                    Text("Don't have an account?")
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button(action: {model.isSignUp.toggle()}){
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top,25)
                Spacer(minLength: 0)
                Button(action: model.resetPassword){
                    Text("Forgot Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical,22)
                
            }
            if model.isLoading{
                LoadingView()
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all,edges: .all))
        .fullScreenCover(isPresented: $model.isSignUp) {
            SignUpView(model: model)
        }
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })

    }
}

struct CustomTextField: View{
    var image : String
    var placeHolder: String
    @Binding var txt: String
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(Color("bottom"))
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            ZStack{
                if placeHolder == "Password" || placeHolder == "Re-Enter" {
                    SecureField(placeHolder, text: $txt)
                }else{
                    TextField(placeHolder, text: $txt)
                }
            }
                .padding(.horizontal).padding(.leading,65).frame(height: 60).background(Color.white.opacity(0.2)).clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct SignUpView: View {
    @ObservedObject var model : ModelData
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            
            VStack{
                Spacer(minLength: 0)
                
                ZStack{
                    if UIScreen.main.bounds.height < 750{
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 130)
                    }
                    else{
                        Image("logo")
                    }
                }
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                .padding(.top)
                
                VStack(spacing: 4){
                    
                    HStack(spacing: 0){
                        
                        Text("New Profile")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    
                    Text("Create a new profile and start managing your stable!")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email_SignUp)
                    
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password_SignUp)
                    
                    CustomTextField(image: "lock", placeHolder: "Re-Enter", txt: $model.reEnterPassword)
                }
                .padding(.top)
                
                Button(action: model.signUp){
                    Text("SIGNUP")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.vertical,22)
                
                Spacer(minLength: 0)
            }
            
            Button(action: {model.isSignUp.toggle()}){
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.trailing)
            .padding(.top,10)
            
            if model.isLoading{
                LoadingView()
            }
        })
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                 
                // if email link sent means closing the signupView....
                
                if model.alertMsg == "Email Verification Has Been Sent !!! Verify Your Email ID !!!"{
                    
                    model.isSignUp.toggle()
                    model.email_SignUp = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                }
                
            }))
        })
    }
}

// MVVM Model...
class ModelData : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    @Published var resetEmail = ""
    @Published var isLinkSend = false
    
    //AlertView with TextFields
    
    //Error Alerts
    @Published var alert = false
    @Published var alertMsg = ""
    
    //User Status
    @AppStorage("log_Status") var status = false
    
    //Loading
    @Published var isLoading = false
    
    func resetPassword(){
        
        let alert = UIAlertController(title: "Reset Password", message: "Please Enter your Email to Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField{ (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            
            // Sending Password Link...
            
            if alert.textFields![0].text! != ""{
                
                withAnimation{
                    
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    withAnimation{
                        
                        self.isLoading.toggle()
                    }
                    
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    // ALerting User...
                    self.alertMsg = "Your Password Reset Link Has Been Sent"
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting ...
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert,animated: true)
    }
    
    //Login
    func login(){
        
        //checking all fields are inputted correctly
        if email == "" || password == "" {
            self.alertMsg = "Please complete the required fields"
            self.alert.toggle()
            return
        }
        withAnimation{
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password){(result, err) in
            
            withAnimation{
                self.isLoading.toggle()
            }
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            //check if user is verfied or not
            //if not verified than logged out
            
            let user = Auth.auth().currentUser
            if !user!.isEmailVerified{
                self.alertMsg = "Please verify email address"
                self.alert.toggle()
                // logging out
                try! Auth.auth().signOut()
                
                return
            }
            
            //setting user status as true
            withAnimation{
                self.status = true
            }
        }
    }
    
    func signUp(){
        
        // checking....
        
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == ""{
            
            self.alertMsg = "Fill contents proprely!!!"
            self.alert.toggle()
            return
        }
        
        if password_SignUp != reEnterPassword{
            
            self.alertMsg = "Password Mismatch !!!"
            self.alert.toggle()
            return
        }
        
        withAnimation{
            
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            if let user = user {
                let uid = user.uid
                let email = user.email
                let date = Date()
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .medium
                db.collection("RiderProfiles").document(uid).setData(["Age": 0, "Email": email ?? "", "Gender": 0, "Height": 0, "ID": uid, "Joined Date": formatter1.string(from: date), "Owned Horse": "", "Phone": "", "name": "User", "Horse Name": "", "Instructor": "", "Instructor Name": ""], merge:true)
                self.uploadImage(image: UIImage(imageLiteralResourceName: "Lebron"), id: uid)
            }
            
            // sending Verifcation Link....
            
            result?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                // Alerting User To Verify Email...
                
                self.alertMsg = "Email Verification Has Been Sent !!! Verify Your Email ID !!!"
                self.alert.toggle()
            })
        }
    }
    
    func uploadImage(image: UIImage, id: String) {
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
    
    // log Out...
    
    func logOut(){
        
        try! Auth.auth().signOut()
        
        withAnimation{
            
            self.status = false
        }
        
        // clearing all data...
        
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
    
}

// Loading View
struct LoadingView : View {
    
    @State var animation = false
    
    var body: some View{
        
        VStack{
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color("bottom"),lineWidth: 8)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            
            withAnimation(Animation.linear(duration: 1)){
                
                animation.toggle()
            }
        })
    }
}
