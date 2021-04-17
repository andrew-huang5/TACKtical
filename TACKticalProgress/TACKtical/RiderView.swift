//
//  RiderView.swift
//  TACKtical
//
//
import SwiftUI

struct RiderView: View {
    var body: some View {
        
        GeometryReader{ geometry in
            VStack(){
                Image("Lebron").resizable().clipShape(Circle()).shadow(radius:10).overlay(Circle().stroke(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0), lineWidth: 5)).frame(width:UIScreen.main.bounds.height * 0.2, height:UIScreen.main.bounds.height*0.2).padding(UIScreen.main.bounds.height*0.005)
                Text("Lebron James").fontWeight(.semibold).multilineTextAlignment(.center).font(.system(size:UIScreen.main.bounds.height*0.045)).frame(height: UIScreen.main.bounds.height * 0.035).padding(UIScreen.main.bounds.height*0.005)
                Button(action: {print("Going to upcoming Training Rides")}) {
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
                    NavigationLink(destination: NewProfileView(id: "Horse1")) {
                        Text("Horse Profile").font(.system(size:UIScreen.main.bounds.height*0.025))
                    }.frame(width:UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height*0.008, alignment:.center).foregroundColor(.white).padding(UIScreen.main.bounds.height*0.02).background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).cornerRadius(16)
                }.padding(UIScreen.main.bounds.height*0.005)
            }
            .padding(EdgeInsets(top: 0.05, leading: UIScreen.main.bounds.width*0.155, bottom: 0.05, trailing: UIScreen.main.bounds.width*0.155)).navigationBarTitle("Rider Profile", displayMode: .inline)
        }
    }
}

struct RiderView_Previews: PreviewProvider {
    static var previews: some View {
        RiderView()
    }
}
