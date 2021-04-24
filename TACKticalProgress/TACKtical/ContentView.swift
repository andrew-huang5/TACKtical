//
//  ContentView.swift
//  TACKtical
//
//  Created by Andrew Huang on 3/28/21.
//
import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView{
            HomeView()
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
