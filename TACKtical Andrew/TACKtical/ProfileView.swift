//
//  ContentView.swift
//  TACKtical
//
//  Created by Andrew Huang on 3/28/21.
//

import SwiftUI


//    @State var riderProfile = false
//    @State var horseProfile = false
//    @State var editProfile = false
//
//    var body: some View {
//        if riderProfile {
//            RiderView(horseProfile: $horseProfile, riderProfile: $riderProfile, editProfile: $editProfile)
//        }
//        else if horseProfile{
//            HorseView(riderProfile: $riderProfile, horseProfile: $horseProfile, editProfile: $editProfile)
//        }
//        else if editProfile{
//            editView(horseProfile: $horseProfile, editProfile: $editProfile)
//        }
//        else{
//            HorseView(riderProfile: $riderProfile, horseProfile: $horseProfile, editProfile: $editProfile)
//        }
//    }




struct HorseView: View {
    @Binding var riderProfile: Bool
    @Binding var horseProfile: Bool
    @Binding var editProfile: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(){
                Text("Horse Profile").fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: UIScreen.main.bounds.height*0.05)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).padding(UIScreen.main.bounds.height*0.005)
                Image("Horse").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text("Mayor").fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                Button(action: {
                    editProfile = true
                    riderProfile = false
                    horseProfile = false
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
                        riderProfile = true
                        horseProfile = false
                        editProfile = false
                    }) {
                        Text("Rider Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                }.padding(UIScreen.main.bounds.height*0.005)
            }
            .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092))
        }
    }
}


struct RiderView: View {
    @Binding var horseProfile: Bool
    @Binding var riderProfile: Bool
    @Binding var editProfile: Bool
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack(){
                Text("Rider Profile").fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: UIScreen.main.bounds.height*0.05)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).padding(UIScreen.main.bounds.height*0.005)
                Image("Lebron").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text("Lebron James").fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                Button(action: {
                    editProfile = true
                    horseProfile = false
                    riderProfile = false
                }) {
                    Text("Edit Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.frame(width:UIScreen.main.bounds.width*0.3, height:UIScreen.main.bounds.height*0.035, alignment:.center).foregroundColor(.black).background(Color(UIColor.lightGray)).opacity(0.7).cornerRadius(16).padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Text("Joined Date: Dec/30/2020").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Gender: Female").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Age: 36").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Height: 6.8 ft").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Owned Horse: Mayor ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Email: xxxxx@xxxx.com").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Phone: xxx-xxx-xxxx").font(.system(size:UIScreen.main.bounds.height*0.025))
                }.padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Button(action: {
                        print("Going to upcoming Training Rides")
                    }) {
                        Text("Upcoming Training Rides").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                    Button(action: {
                        horseProfile = true
                        riderProfile = false
                    }) {
                        Text("Horse Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                }.padding(UIScreen.main.bounds.height*0.005)
            }
            .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092))
        }
    }
}


struct editView: View {
    @Binding var horseProfile: Bool
    @Binding var editProfile: Bool
    
    @State private var height: String = ""
    @State private var owner: String = ""
    @State private var feed: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(){
                Text("Edit Profile").fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: UIScreen.main.bounds.height*0.05)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).padding(UIScreen.main.bounds.height*0.005)
                Image("Horse").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text("Mayor").fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Text("Date of Birth: Jan/1/2015").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Gender: Female").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Color: Chestnut").font(.system(size:UIScreen.main.bounds.height*0.025))
                    HStack{
                        Text("Height: ")
                        TextField("5.3 ft", text: $height)
                    }.font(.system(size:UIScreen.main.bounds.height*0.025))
                    HStack{
                        Text("Owner: ")
                        TextField("Lebron James", text: $owner)
                    }.font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("Arrival Date: Jan/1/2020").font(.system(size:UIScreen.main.bounds.height*0.025))
                    HStack{
                        Text("Feed: ")
                        TextField("Hay & Grain", text: $feed)
                    }.font(.system(size:UIScreen.main.bounds.height*0.025))
                }.padding(UIScreen.main.bounds.height*0.005)
            
                VStack(alignment: .center, spacing: UIScreen.main.bounds.height*0.01){
                    Button(action: {
                        horseProfile = true
                        editProfile = false
                    }) {
                        Text("Save Changes").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                }.padding(UIScreen.main.bounds.height*0.005)
            }
            .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092))
        }
    }
}
