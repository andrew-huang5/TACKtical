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
        ZStack(){
            Text("Horse Profile").fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: 30)).frame(width: 325, height: 80).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).position(x:195, y:40)
            Image("Horse").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:150, height:150).position(x:200, y: 175)
            Text("Mayor").fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:28)).padding(20).position(x:200, y:285)
            Button(action: {
                print("Changing to Editing Profile")
            }) {
                Text("Edit Profile")
            }.frame(width:100, height:10, alignment:.center).foregroundColor(.black).padding(.all).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).position(x:200, y:335)
            
            VStack(alignment: .center, spacing: 15){
                Text("Date of Birth: Jan/1/2015")
                Text("Gender: Female")
                Text("Color: Chestnut")
                Text("Height: 5.3 ft")
                Text("Owner: Lebron James")
                Text("Arrival Date: Jan/1/2020")
                Text("Feed: Hay & Grain")
            }.position(x:200, y: 500)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15){
                Button(action: {
                    print("Going to upcoming Training Rides")
                }) {
                    Text("Upcoming Training Rides")
                }.frame(width:200, height:10, alignment:.center).foregroundColor(.white).padding(.all).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                Button(action: {
                    print("Going to Rider Profile")
                }) {
                    Text("Rider Profiles")
                }.frame(width:200, height:10, alignment:.center).foregroundColor(.white).padding(.all).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
            }.position(x:200, y:685)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
