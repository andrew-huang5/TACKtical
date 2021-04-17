//
//  CalendarView.swift
//  TACKtical
//
//  Created by Haris Nashed on 4/11/21.
//

import SwiftUI
import UIKit
import FSCalendar
    
class CalendarData: ObservableObject{
        
   @Published var selectedDate : Date = Date()
   @Published var titleOfMonth : Date = Date()
   @Published var crntPage: Date = Date()
        
}
struct CalendarView: View {
    
    @ObservedObject private var calendarData = CalendarData()
    
    var strDateSelected: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: calendarData.selectedDate)
    }
    
    var strMonthTitle: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: calendarData.titleOfMonth)
    }
    
    var body: some View {
        VStack {
            
            HStack(spacing: 60) {
                
                Button(action: {
                                    
                    self.calendarData.crntPage = Calendar.current.date(byAdding: .month, value: -1, to: self.calendarData.crntPage)!
                    
                }) { Image(systemName: "arrow.left") }
                    .frame(width: 35, height: 35, alignment: .leading)
            
                NavigationLink(destination: AddEventView(start: Date(), end: Date().addingTimeInterval(3600))) {
                    Text("+").font(.system(size: 25))
                }.frame(width: UIScreen.main.bounds.width*0.1, height:UIScreen.main.bounds.width*0.1)
                .foregroundColor(Color.white)
                .background(Color(red: 102/255, green: 172/255, blue: 189/255, opacity: 1.0))
                
                Button(action: {
                    
                    self.calendarData.crntPage = Calendar.current.date(byAdding: .month, value: 1, to: self.calendarData.crntPage)!
                    
                }) { Image(systemName: "arrow.right") }
                .frame(width: 35, height: 35, alignment: .trailing)
            }
            
            CustomCalendar(dateSelected: $calendarData.selectedDate, mnthNm: $calendarData.titleOfMonth, pageCurrent: $calendarData.crntPage)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 10.0, x: 0.0, y: 0.0)
                )
                .frame(height: UIScreen.main.bounds.height * 0.75)
                .padding(15)
        }.navigationBarTitle("Schedule")
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomCalendar: UIViewRepresentable {
   
    typealias UIViewType = FSCalendar
    
    @Binding var dateSelected: Date
    @Binding var mnthNm: Date
    @Binding var pageCurrent: Date
    
    var calendar = FSCalendar()
    
    var today: Date{
        return Date()
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        calendar.appearance.headerMinimumDissolvedAlpha = 0
       
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
        uiView.setCurrentPage(pageCurrent, animated: true) // --->> update calendar view when click on left or right button
    }
    
    func makeCoordinator() -> CustomCalendar.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        
        var parent: CustomCalendar
        
        init(_ parent: CustomCalendar) {
            
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
            parent.dateSelected = date
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            
            parent.pageCurrent = calendar.currentPage
            parent.mnthNm = calendar.currentPage
        }
    }
}
