//
//  MenuView.swift
//  TACKtical
//
//  Created by Andrew Huang on 4/18/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        HStack(spacing:80){
            GoHome()
            Iforgot()
            GoCalendar()
        }
    }
}

struct GoHome: View {
    var body: some View{
        NavigationLink(destination: ContentView()) {
            Image("Home").resizable().aspectRatio(contentMode: .fill)
        }.frame(width:UIScreen.main.bounds.width*0.06, height:UIScreen.main.bounds.height*0.06, alignment:.center)
    }
}

struct Iforgot: View {
    var body: some View{
        NavigationLink(destination: ContentView()) {
            Text("TEMP")
            //Image("Home").resizable().aspectRatio(contentMode: .fill)
        }.frame(width:UIScreen.main.bounds.width*0.06, height:UIScreen.main.bounds.height*0.06, alignment:.center)
    }
}

struct GoCalendar: View {
    var body: some View{
        NavigationLink(destination: CalendarView()) {
            Image("Calendar").resizable().aspectRatio(contentMode: .fill)
        }.frame(width:UIScreen.main.bounds.width*0.06, height:UIScreen.main.bounds.height*0.06, alignment:.center)
    }
}

/*
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}*/
