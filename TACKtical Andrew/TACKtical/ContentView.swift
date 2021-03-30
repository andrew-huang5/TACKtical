//
//  ContentView.swift
//  TACKtical
//
//  Created by Andrew Huang on 3/28/21.
//

import SwiftUI


struct ContentView: View {
    @State private var editProfile = false
//    var horse = Horse(DOB: "2021", height: 16, horseID: 1, name: "Haha", weight: 200)
    
    @ObservedObject private var viewModel = HorseViewModel()
    //var horse = viewModel.horses[0]
    
    
    var body: some View {
        NavigationView{
            VStack(){
//                Text("Horse Profile").fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: UIScreen.main.bounds.height*0.05)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).padding(UIScreen.main.bounds.height*0.005)
                Image("Horse").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text(viewModel.horse.name).fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Text("Date of Birth: " + viewModel.horse.birth).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Gender: " + viewModel.horse.gender).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Color: " + viewModel.horse.color).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Height: " + viewModel.horse.height).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Owner: " + viewModel.horse.owner).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Arrival Date: " + viewModel.horse.arrivalDate).font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Feed: " + viewModel.horse.feed).font(.system(size:UIScreen.main.bounds.height*0.025))
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
            .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("Horse Profile", displayMode: .inline)
        }.onAppear() {
            self.viewModel.fetchData()
            UINavigationBar.appearance().backgroundColor = UIColor(red: 102/255, green: 172/255, blue: 189/255, alpha:1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
