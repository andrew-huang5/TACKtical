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
    @ObservedObject var eventViewModel = EventViewModel()
    let timeFormatter = DateFormatter()
    
    var strDateSelected: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        VStack(){
//            Text("Hello \(viewModel.rider.name),\nHere is a preview of your day:").font(.system(size:UIScreen.main.bounds.height*0.025)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1).background(Color(red: 173/255, green: 216/255, blue: 230/255, opacity: 1.0)).onAppear(){
//                viewModel.fetchData(id: Auth.auth().currentUser!.uid)
//            }
            VStack(spacing: UIScreen.main.bounds.height*0.02) {
                ForEach (eventViewModel.events, id: \.self) { i in
                    if (i.id.starts(with: strDateSelected)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(i.startTimeString+"  ~").onAppear(){
                                    timeFormatter.timeStyle = .short
                                }.font(.system(size:UIScreen.main.bounds.height*0.025))
                                Text(i.endTimeString).onAppear(){
                                    timeFormatter.timeStyle = .short
                                }.font(.system(size:UIScreen.main.bounds.height*0.025))
                            }
                            if i.type == "Lesson" || i.type == "Training" || i.type == "Custom" {
                                (Text(i.title) + Text(" with " + i.horseName + " (Horse) and ") + Text(i.riderName + " (Rider)")).font(.system(size:UIScreen.main.bounds.height*0.022))
                            } else {
                                (Text(i.title) + Text(" with " + i.horseName + " (Horse)")).font(.system(size:UIScreen.main.bounds.height*0.022))
                            }

                        }.frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width*0.15, bottom: UIScreen.main.bounds.height*0.01, trailing: UIScreen.main.bounds.width*0.15)).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5).background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0)).onAppear() {
                self.eventViewModel.fetchAllData()
            }
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
