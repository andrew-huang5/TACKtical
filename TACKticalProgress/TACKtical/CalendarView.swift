//
//  CalendarView.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/11/21.
//

import Foundation
import FSCalendar
import SwiftUI

//struct CalendarView: View {
//    var calendar = FSCalendar(frame: CGRect(x: 10.0, y: 10.0, width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.7))
//
//    var body: some View {
//        calendar
//    }
//}

struct CalendarView: UIViewRepresentable {

func makeUIView(context: Context) -> UIView {
    let calendar = FSCalendar(frame: CGRect(x: 0.0, y: 40.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    calendar.scrollDirection = .vertical
    return calendar
}

func updateUIView(_ uiView: UIView, context: Context) {
}
}
