//
//  CalendarView.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/8/21.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    @State var title = ""
    @State var start = "" // Date()
    @State var end = "" // Date()
    @State var rep = false
    @State var notify = false
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
        }.padding()
        VStack {
            TextField("Start", text: $start)
        }
        VStack {
            TextField("End", text: $end)
        }
        VStack {
            TextField("Title", text: $title)
        }
        Toggle(isOn: $rep) {
            Text("Repeat")
        }.padding()
        Toggle(isOn: $notify) {
            Text("Notify participants")
        }.padding()
    }
}
