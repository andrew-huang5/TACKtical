//
//  MenuView.swift
//  TACKtical
//
//  Created by Andrew Huang on 4/18/21.
//.toolbar { ToolbarItem(placement: .bottomBar) {MenuView()}}

import SwiftUI
import Firebase

struct MenuView: View {
    var body: some View {
        HStack(spacing:UIScreen.main.bounds.width*0.17){
            GoHome()
//            GoHorse()
//            GoData()
            GoCalendar()
        }
    }
}

struct GoHome: View {
    var body: some View{
        NavigationLink(destination: HomeView()) {
            Image("Home").resizable().aspectRatio(contentMode: .fill)
        }.frame(width:UIScreen.main.bounds.width*0.06, height:UIScreen.main.bounds.height*0.06, alignment:.center)
    }
}

//struct GoHorse: View {
//    var body: some View{
//        NavigationLink(destination: NewRiderProfileView(id: Auth.auth().currentUser!.uid)) {
//            Image("HorseMenu").resizable().aspectRatio(contentMode: .fill)
//        }.frame(width:UIScreen.main.bounds.width*0.05, height:UIScreen.main.bounds.height*0.05, alignment:.center)
//    }
//}
//
//struct GoData: View {
//    @ObservedObject private var viewModel = RiderViewModel()
//    var body: some View{
//        NavigationLink(destination: BarnDataView(horseId:viewModel.rider.horse, instructorId:viewModel.rider.instructor)) {
//            Image("Data").resizable().aspectRatio(contentMode: .fill)
//        }.onAppear{
//            self.viewModel.fetchData(id: Auth.auth().currentUser!.uid)
//        }.frame(width:UIScreen.main.bounds.width*0.05, height:UIScreen.main.bounds.height*0.05, alignment:.center)
//    }
//}

struct GoCalendar: View {
    var body: some View{
        NavigationLink(destination: CalendarView()) {
            Image("Calendar").resizable().aspectRatio(contentMode: .fill)
        }.frame(width:UIScreen.main.bounds.width*0.08, height:UIScreen.main.bounds.height*0.08, alignment:.center)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
