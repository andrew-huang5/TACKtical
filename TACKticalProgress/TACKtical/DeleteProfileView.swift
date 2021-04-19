//
//  DeleteProfileView.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/13/21.
//

import SwiftUI
import Firebase

struct DeleteProfileView: View {
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("Choose the Profile to Delete:").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.02, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.005, trailing: UIScreen.main.bounds.width*0.15))
                }
                ZStack {
                    VStack {
                        Text("Horse Profiles:").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.005, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.03, trailing: UIScreen.main.bounds.width*0.15))
                        
                        Text("Rider Profiles:").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.03, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.03, trailing: UIScreen.main.bounds.width*0.15))
                        
                        Text("Instructor Profiles:").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.03, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.002, trailing: UIScreen.main.bounds.width*0.15))
                    }
                    HStack {
                        Dropdown4()
                    }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.1, trailing: UIScreen.main.bounds.width*0.15)).zIndex(10)
                    
                    HStack {
                        Dropdown5()
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height*0.1, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15)).zIndex(10)
                    
                    HStack {
                        Dropdown6()
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height*0.3, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15))
                }
            }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.01, trailing: UIScreen.main.bounds.width*0.15)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("Delete Profiles", displayMode: .inline)
        
    }
    
    
}

struct DeleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteProfileView()
    }
}

struct Dropdown4: View{
    @State var horse: Horse = Horse(id: "", arrivalDate: Date(), height: 0, gender: 0, birth: Date(), owner: "", feed: 0, color: 0, name: "", ownerName: "")
    @ObservedObject private var viewModel = HorseViewModel()
    @State private var showPopUp: Bool = false
    @State var expand = false
    var body: some View{
        ZStack() {
            VStack() {
                VStack() {
                    HStack() {
                        Text("Horse Name").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width:UIScreen.main.bounds.width*0.63)
                        Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:UIScreen.main.bounds.width*0.03, height:UIScreen.main.bounds.height*0.015)
                    }.onTapGesture {
                        self.expand.toggle()
                    }
                    
                    if expand{
                        List(viewModel.horses, id: \.self) { horse in
                            Button(action: {
                                self.horse = horse
                                withAnimation(.linear(duration: 0.3)) {
                                    showPopUp.toggle()
                                }
                                //deleteProfile(horse: horse)
                                
                            }) {
                                Text(horse.name).font(.system(size:UIScreen.main.bounds.height*0.02)).foregroundColor(.black)
                            }
                            
                        }
                        
                    }
                }.onAppear() {
                    self.viewModel.fetchAllData()
                }.background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).cornerRadius(3)
            }
            PopUpWindow(title: "Notice", message: "Sure about deleting this?", buttonText1: "Yes", buttonText2: "No", horse: horse, show: $showPopUp)
        }
        
        
    }
}

struct Dropdown5: View{
    @State var rider: Rider = Rider(id: "", joinedDate: Date(), height: 0, gender: 0, age: 0, horse: "", name: "", email: "", phone: "", horseName: "")
    @ObservedObject private var viewModel = RiderViewModel()
    @State private var showPopUp: Bool = false
    @State var expand = false
    var body: some View{
        ZStack() {
            VStack() {
                VStack() {
                    HStack() {
                        Text("Horse Name").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width:UIScreen.main.bounds.width*0.63)
                        Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:UIScreen.main.bounds.width*0.03, height:UIScreen.main.bounds.height*0.015)
                    }.onTapGesture {
                        self.expand.toggle()
                    }
                    
                    if expand{
                        List(viewModel.riders, id: \.self) { rider in
                            Button(action: {
                                self.rider = rider
                                withAnimation(.linear(duration: 0.3)) {
                                    showPopUp.toggle()
                                }
                                //deleteProfile(horse: horse)
                                
                            }) {
                                Text(rider.name).font(.system(size:UIScreen.main.bounds.height*0.02)).foregroundColor(.black)
                            }
                            
                        }
                        
                    }
                }.onAppear() {
                    self.viewModel.fetchAllData()
                }.background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).cornerRadius(3)
            }
            PopUpWindowforRider(title: "Notice", message: "Sure about deleting this?", buttonText1: "Yes", buttonText2: "No", rider: rider, show: $showPopUp)
        }
        
        
    }
}

struct Dropdown6: View{
    @State var expand = false
    var body: some View{
        VStack() {
            VStack() {
                HStack() {
                    Text("Instructor Name").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width:UIScreen.main.bounds.width*0.63)
                    Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:UIScreen.main.bounds.width*0.03, height:UIScreen.main.bounds.height*0.015)
                }.onTapGesture {
                    self.expand.toggle()
                }
                
                if expand{
                    NavigationLink(destination: NewProfileView(id: "Horse1")) {
                        Text("Mayor").font(.system(size:UIScreen.main.bounds.height*0.02)).foregroundColor(.black)
                    }
                }
            }.background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).cornerRadius(3)
        }
    }
}

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText1: String
    var buttonText2: String
    var horse: Horse
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
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    HStack() {
                        Button(action: {
                            // Dismiss the PopUp
                            deleteProfile(horse: horse)
                            deleteImage(horse: horse)
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
    func deleteProfile(horse: Horse) {
        let db = Firestore.firestore()
        db.collection("HorseProfiles").document(horse.id).delete()
    }
    func deleteImage(horse: Horse) {
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let desertRef = storage.reference().child("\(horse.id)/\(horse.id)")

        // Delete the file
        desertRef.delete { error in
            if let error = error {
                print("an error has occured - \(error.localizedDescription)")
            } else {
                print("Image deleted successfully!")
          }
        }
    }
}

struct PopUpWindowforRider: View {
    var title: String
    var message: String
    var buttonText1: String
    var buttonText2: String
    var rider: Rider
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
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    HStack() {
                        Button(action: {
                            // Dismiss the PopUp
                            deleteProfile(rider: rider)
                            deleteImage(rider: rider)
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Text(buttonText2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                                .font(Font.system(size: 23, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
    func deleteProfile(rider: Rider) {
        let db = Firestore.firestore()
        db.collection("RiderProfiles").document(rider.id).delete()
    }
    func deleteImage(rider: Rider) {
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let desertRef = storage.reference().child("\(rider.id)/\(rider.id)")

        // Delete the file
        desertRef.delete { error in
            if let error = error {
                print("an error has occured - \(error.localizedDescription)")
            } else {
                print("Image deleted successfully!")
          }
        }
    }
}
