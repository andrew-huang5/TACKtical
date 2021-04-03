//
//  BarnDataView.swift
//  TACKtical
//
//

import SwiftUI

struct BarnDataView: View {
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("Suggested: ").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading)
                    HStack(spacing: UIScreen.main.bounds.width*0.08) {
                        Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                        .foregroundColor(Color.white)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                        .foregroundColor(Color.white)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Text("Image").frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2)
                        .foregroundColor(Color.white)
                        .background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }.padding(UIScreen.main.bounds.height*0.005)
                    
                    Text("Search by:").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.02, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.005, trailing: UIScreen.main.bounds.width*0.15))
                }
                
                ZStack {
                    VStack {
                        Text("Horse Profiles:").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.005, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.03, trailing: UIScreen.main.bounds.width*0.15))
                        
                        Text("Rider Profiles:").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.03, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.03, trailing: UIScreen.main.bounds.width*0.15))
                        
                        Text("Instructor Profiles:").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading).padding(EdgeInsets(top: UIScreen.main.bounds.height*0.03, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.002, trailing: UIScreen.main.bounds.width*0.15))
                    }
                    
                    HStack {
                        Dropdown1()
                    }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.1, trailing: UIScreen.main.bounds.width*0.15)).zIndex(10)
                    
                    HStack {
                        Dropdown2()
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height*0.1, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15))
                    
                    HStack {
                        Dropdown3()
                    }.padding(EdgeInsets(top: UIScreen.main.bounds.height*0.3, leading: UIScreen.main.bounds.width*0.15, bottom: 0, trailing: UIScreen.main.bounds.width*0.15))
                    
                }
            }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.01, trailing: UIScreen.main.bounds.width*0.15)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.7).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
            
            HStack(spacing: UIScreen.main.bounds.width*0.15) {
                NavigationLink(
                    destination: CreateProfileView()) {
                    Text("Create \nProfile").foregroundColor(.black)
                }.frame(width:UIScreen.main.bounds.width*0.25, height:UIScreen.main.bounds.height*0.09).font(.system(size:UIScreen.main.bounds.height*0.03)).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
                
                NavigationLink(
                    destination: CreateProfileView()) {
                    Text("Edit/Delete \nProfile").foregroundColor(.black)
                }.frame(width:UIScreen.main.bounds.width*0.25, height:UIScreen.main.bounds.height*0.09).font(.system(size:UIScreen.main.bounds.height*0.025)).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
            }
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("Barn Data", displayMode: .inline)
    }
}

struct BarnDataView_Previews: PreviewProvider {
    static var previews: some View {
        BarnDataView()
    }
}

struct Dropdown1: View{
    @State var expand = false
    var body: some View{
        VStack() {
            VStack() {
                HStack() {
                    Text("Horse Name").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width:UIScreen.main.bounds.width*0.63)
                    Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:UIScreen.main.bounds.width*0.03, height:UIScreen.main.bounds.height*0.015)
                }.onTapGesture {
                    self.expand.toggle()
                }
                
                if expand{
                    NavigationLink(destination: NewProfileView()) {
                        Text("Mayor").font(.system(size:UIScreen.main.bounds.height*0.02)).foregroundColor(.black)
                    }
                }
            }.background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).cornerRadius(3)
        }
    }
}

struct Dropdown2: View{
    @State var expand = false
    var body: some View{
        VStack() {
            VStack() {
                HStack() {
                    Text("Rider Name").font(.system(size:UIScreen.main.bounds.height*0.02)).frame(width:UIScreen.main.bounds.width*0.63)
                    Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:UIScreen.main.bounds.width*0.03, height:UIScreen.main.bounds.height*0.015)
                }.onTapGesture {
                    self.expand.toggle()
                }
                
                if expand{
                    NavigationLink(destination: NewProfileView()) {
                        Text("Mayor").font(.system(size:UIScreen.main.bounds.height*0.02)).foregroundColor(.black)
                    }
                }
            }.background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).cornerRadius(3)
        }
    }
}

struct Dropdown3: View{
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
                    NavigationLink(destination: NewProfileView()) {
                        Text("Mayor").font(.system(size:UIScreen.main.bounds.height*0.02)).foregroundColor(.black)
                    }
                }
            }.background(Color(red: 211/255, green: 211/255, blue: 211/255, opacity: 1.0)).cornerRadius(3)
        }
    }
}
