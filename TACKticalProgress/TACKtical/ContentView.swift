//
//  ContentView.swift
//  TACKtical
//
//  Created by Andrew Huang on 3/28/21.
//
import SwiftUI


struct ContentView: View {
//    @State private var editProfile = false
//    var horse = Horse(DOB: "2021", height: 16, horseID: 1, name: "Haha", weight: 200)
    
    @ObservedObject private var viewModel = HorseViewModel()
    //var horse = viewModel.horses[0]
    
    
    var body: some View {
        NavigationView{
            VStack(){
                Text("Hello User,\nHere is a preview of your day:").font(.system(size:UIScreen.main.bounds.height*0.03)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 173/255, green: 216/255, blue: 230/255, opacity: 1.0))
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
                
                HStack(spacing: UIScreen.main.bounds.width*0.1) {
                    NavigationLink(destination: BarnDataView()) {
                        Text("Barn Data")
                    }.frame(width: UIScreen.main.bounds.width*0.23, height: UIScreen.main.bounds.width*0.23)
                    .foregroundColor(Color.white)
                    .background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    NavigationLink(destination: CalendarView()) {
                                            Text("Schedule")
                                        }.frame(width: UIScreen.main.bounds.width*0.23, height: UIScreen.main.bounds.width*0.23)
                                        .foregroundColor(Color.white)
                                        .background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0)).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                
                
            }
            .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.092, bottom: 0, trailing: UIScreen.main.bounds.width*0.092)).navigationBarTitle("TACKtical", displayMode: .inline)
        }.onAppear() {
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
