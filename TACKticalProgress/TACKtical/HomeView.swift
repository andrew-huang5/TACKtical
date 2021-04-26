//
//  HomeView.swift
//  TACKtical
//
//  Created by 谢正恺 on 4/23/21.
//
import SwiftUI
import Firebase

struct HomeView: View {
    @StateObject var model = ModelData()
    @ObservedObject var viewModel = RiderViewModel()
    
    var body: some View {
        VStack(){
            Text("Hello \(viewModel.rider.name),\nHere is a preview of your day:").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 173/255, green: 216/255, blue: 230/255, opacity: 1.0)).onAppear(){
                viewModel.fetchData(id: Auth.auth().currentUser!.uid)
            }
            VStack(spacing: UIScreen.main.bounds.height*0.02) {
                VStack(alignment: .leading){
                    Text("9:00 am ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("\tRise and shine").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                }
                VStack(alignment: .leading){
                    Text("10:00 am ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("\tLesson with Bob").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                }
                VStack(alignment: .leading){
                    Text("11:00 am ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("\tPrepare lunch for meeting").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                }
                VStack(alignment: .leading){
                    Text("12:00 pm ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("\tLunch meeting with partners").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                }
                VStack(alignment: .leading){
                    Text("1:00 pm ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("\tFix the broken gate").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                }
                VStack(alignment: .leading){
                    Text("2:00 pm ").font(.system(size:UIScreen.main.bounds.height*0.025))
                    Text("\tStable cleaning").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                }
            }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.01, trailing: UIScreen.main.bounds.width*0.15)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
            MenuView()
            Button(action: model.logOut, label: {
                Text("LogOut")
                    .fontWeight(.bold)
            })
        }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("TACKtical", displayMode: .inline)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
