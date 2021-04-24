//
//  BarnDataView.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/3/21.
//
import SwiftUI

struct BarnDataView: View {
    @ObservedObject private var viewModel = NameViewModel()
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                CustomAllSearchBar(objectnames: $viewModel.ObjectNames).padding(.top).zIndex(10)
                
                VStack {
                    Text("Suggested: ").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding()
                    HStack(spacing: UIScreen.main.bounds.width*0.08) {
                        Image("Horse").resizable().clipShape(Circle()).frame(width:UIScreen.main.bounds.width * 0.2, height:UIScreen.main.bounds.width*0.2)
                        Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                        .foregroundColor(Color.white)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                        .foregroundColor(Color.white)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    
                    Text("Create Profiles:").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding()
                    
                    HStack(spacing: UIScreen.main.bounds.width*0.07) {
                        NavigationLink(
                            destination: CreateHorseProfileView()) {
                            Text("Horse \nProfile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(.black)
                        }.frame(width:UIScreen.main.bounds.width*0.2, height:UIScreen.main.bounds.height*0.09).font(.system(size:UIScreen.main.bounds.height*0.03)).background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0))
                        
                        NavigationLink(
                            destination: CreateRiderProfileView()) {
                            Text("Rider \nProfile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(Color.black)
                        }.frame(width:UIScreen.main.bounds.width*0.2, height:UIScreen.main.bounds.height*0.09).background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0))
                        
                        NavigationLink(
                            destination: CreateInstructorProfileView()) {
                            Text("Instructor \nProfile").font(.system(size:UIScreen.main.bounds.height*0.025)).foregroundColor(Color.black)
                        }.frame(width:UIScreen.main.bounds.width*0.2, height:UIScreen.main.bounds.height*0.09).background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0))
                    }.padding()
                    
                }.position(x:UIScreen.main.bounds.width*0.35, y: UIScreen.main.bounds.height*0.29)
            }.onAppear{
                self.viewModel.fetchAllData()
            }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.01, trailing: UIScreen.main.bounds.width*0.15)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
            
            MenuView()
            
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("Barn Data", displayMode: .inline)
    }
}

struct BarnDataView_Previews: PreviewProvider {
    static var previews: some View {
        BarnDataView()
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
