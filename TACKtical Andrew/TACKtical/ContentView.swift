//
//  ContentView.swift
//  TACKtical
//
//  Created by Andrew Huang on 3/28/21.
//

import SwiftUI


struct ContentView: View {
    @State private var editProfile = false
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(){
                Text("Horse Profile").fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: UIScreen.main.bounds.height*0.05)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).padding(UIScreen.main.bounds.height*0.005)
                Image("Horse").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text("Mayor").fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                Button(action: {
                    print("Changing to Editing Profile")
                }) {
                    Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Text("Date of Birth: Jan/1/2015").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Gender: Female").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Color: Chestnut").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Height: 5.3 ft").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Owner: Lebron James").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Arrival Date: Jan/1/2020").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Feed: Hay & Grain").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Button(action: {
                        print("Going to upcoming Training Rides")
                    }) {
                        Text("Upcoming Training Rides").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                    Button(action: {
                        print("Going to Rider Profile")
                    }) {
                        Text("Rider Profiles").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                }.padding(UIScreen.main.bounds.height*0.005)
            }
            .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
