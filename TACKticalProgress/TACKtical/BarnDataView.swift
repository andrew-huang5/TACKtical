//
//  BarnDataView.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/3/21.
//
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct BarnDataView: View {
    @ObservedObject private var viewModel = NameViewModel()
    @State var url = ""
    @State var url1 = ""
    @State var url2 = ""
    @State var id: String = Auth.auth().currentUser!.uid
    @State var horseId: String
    @State var instructorId: String
    let idforHorse: String = UUID().uuidString
    let idforRider: String = UUID().uuidString
    let idforInstructor: String = UUID().uuidString
    
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .top) {
                
                
                VStack {
                    Text("Suggested: ").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding()
                    HStack(spacing: UIScreen.main.bounds.width*0.08) {
                        VStack {
                            if url != ""{
                                
                                
                                NavigationLink(destination: NewRiderProfileView(id: id)){
                                    AsyncImage(
                                       url: URL(string: url)!,
                                        placeholder: { Color.black},
                                       image: { Image(uiImage: $0).resizable() }
                                    ).clipShape(Circle()).frame(width:UIScreen.main.bounds.width * 0.2, height:UIScreen.main.bounds.width*0.2).clipShape(Circle()).frame(width:UIScreen.main.bounds.width * 0.2, height:UIScreen.main.bounds.width*0.2)
                                }
                            }
                            else{
                                
                                Loader()
                            }
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
                        
                        VStack {
                            if url1 != ""{
                                
                                
                                NavigationLink(destination: NewProfileView(id: self.horseId)){
                                    AsyncImage(
                                       url: URL(string: url1)!,
                                        placeholder: { Color.black},
                                       image: { Image(uiImage: $0).resizable() }
                                    ).clipShape(Circle()).frame(width:UIScreen.main.bounds.width * 0.2, height:UIScreen.main.bounds.width*0.2)
                                }
                            }
                            else{
                                Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                                .foregroundColor(Color.white)
                                .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .onAppear() {
                            let storage = Storage.storage().reference()
                            storage.child(horseId).listAll{ (result, error) in
                                if let error = error {
                                    print("an error has occured - \(error.localizedDescription)")
                                }
                                if result.items == [] && horseId != ""{
                                    storage.child("Default_Pictures/Horse.png").downloadURL { (url, err) in
                                        if err != nil{

                                            print((err?.localizedDescription)!)
                                            return
                                        }

                                        self.url1 = "\(url!)"
                                    }
                                } else{
                                    storage.child("\(horseId)/\(horseId)").downloadURL { (url, err) in
                                        if err != nil{

                                            print((err?.localizedDescription)!)
                                            return
                                        }

                                        self.url1 = "\(url!)"
                                    }
                                }
                            }
                            
                        }
                        
                        VStack {
                            if url2 != ""{
                                
                                
                                NavigationLink(destination: NewInstructorProfileView(id: self.instructorId)){
                                    AsyncImage(
                                       url: URL(string: url2)!,
                                        placeholder: { Color.black},
                                       image: { Image(uiImage: $0).resizable() }
                                    ).clipShape(Circle()).frame(width:UIScreen.main.bounds.width * 0.2, height:UIScreen.main.bounds.width*0.2).clipShape(Circle()).frame(width:UIScreen.main.bounds.width * 0.2, height:UIScreen.main.bounds.width*0.2)
                                }
                            }
                            else{
                                Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                                .foregroundColor(Color.white)
                                .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .onAppear() {
                            let storage = Storage.storage().reference()
                            storage.child(instructorId).listAll{ (result, error) in
                                if let error = error {
                                    print("an error has occured - \(error.localizedDescription)")
                                }
                                if result.items == [] && instructorId != "" {
                                    storage.child("Default_Pictures/Instructor.png").downloadURL { (url, err) in
                                        if err != nil{

                                            print((err?.localizedDescription)!)
                                            return
                                        }

                                        self.url2 = "\(url!)"
                                    }
                                } else{
                                    print(instructorId + "11111")
                                    storage.child("\(instructorId)/\(instructorId)").downloadURL { (url, err) in
                                        if err != nil{

                                            print((err?.localizedDescription)!)
                                            return
                                        }

                                        self.url2 = "\(url!)"
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    
                    Text("Create Profiles:").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding()
                    
                    HStack(spacing: UIScreen.main.bounds.width*0.07) {
                        NavigationLink(
                            destination: CreateHorseProfileView(id: idforHorse)) {
                            Text("Horse \nProfile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(.black)
                        }.frame(width:UIScreen.main.bounds.width*0.2, height:UIScreen.main.bounds.height*0.09).font(.system(size:UIScreen.main.bounds.height*0.03)).background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0))
                        
                        NavigationLink(
                            destination: CreateRiderProfileView(id: idforRider)) {
                            Text("Rider \nProfile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(Color.black)
                        }.frame(width:UIScreen.main.bounds.width*0.2, height:UIScreen.main.bounds.height*0.09).background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0))
                        
                        NavigationLink(
                            destination: CreateInstructorProfileView(id: idforInstructor)) {
                            Text("Instructor \nProfile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(Color.black)
                        }.frame(width:UIScreen.main.bounds.width*0.2, height:UIScreen.main.bounds.height*0.09).background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0))
                    }.padding()
                    
                }.position(x:UIScreen.main.bounds.width*0.35, y: UIScreen.main.bounds.height*0.29)
                
                CustomAllSearchBar(objectnames: $viewModel.ObjectNames).padding(.top).zIndex(10).onAppear{
                    self.viewModel.fetchAllData()
                }
            }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.01, trailing: UIScreen.main.bounds.width*0.15)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
            
            MenuView()
        }.padding(EdgeInsets(top: UIScreen.main.bounds.height*0.092, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("Barn Data", displayMode: .inline).ignoresSafeArea(.keyboard)
        
    }
}

struct BarnDataView_Previews: PreviewProvider {
    static var previews: some View {
        BarnDataView(horseId: "", instructorId: "")
    }
}

struct CustomAllSearchBar: View {
    
    @Binding var objectnames: [ObjectName]
    @State var txt: String = ""
    @State var id: String = ""
    @State var type: String = ""
    
    var body: some View{
        
        VStack{
            HStack{
                Text("Search")
                TextField("Profile Name", text:self.$txt)
                
                if self.txt != ""{
                    Button(action: {
                        self.txt = ""
                        print(objectnames)
                    }){
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                }
                
            }
            ZStack{
                
                if self.txt != ""{
                    List(self.objectnames.filter{$0.name.lowercased().contains(self.txt.lowercased())}){ i in
                        
                        NavigationLink(destination: {
                            VStack {
                                if i.type == "Horse"{
                                    NewProfileView(id:i.id)
                                } else if i.type == "Rider"{
                                    NewRiderProfileView(id:i.id)
                                } else if i.type == "Instructor"{
                                    NewInstructorProfileView(id:i.id)
                                }
                            }
                        }()) {
                            Text(i.name).bold() + Text("(\(i.type))")
                        }
                        
                    }
                }
                
            }
            
        }.frame(width: UIScreen.main.bounds.width*0.7)
    }
}
