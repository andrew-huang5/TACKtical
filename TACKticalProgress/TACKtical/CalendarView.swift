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
    @ObservedObject private var eventViewModel = EventViewModel()
    let timeFormatter = DateFormatter()
    let uuid = UUID().uuidString
    
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
                
                    NavigationLink(destination: ChooseEventView(date: calendarData.selectedDate)) {
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
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .padding(15)
                
                ScrollView {
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
                                        NavigationLink(destination: EditEventView(type: i.type, eventID: i.id, start: i.startTime, end: i.endTime, date: i.date, title: i.title, horseName: i.horseName, riderName: i.riderName)) {
                                            Text("Edit")
                                        }
                                        
                                    }
                                    if i.type == "Lesson" || i.type == "Training" || i.type == "Custom" {
                                        (Text(i.title) + Text(" with " + i.horseName + " (Horse) and ") + Text(i.riderName + " (Rider)")).font(.system(size:UIScreen.main.bounds.height*0.022))
                                    } else {
                                        (Text(i.title) + Text(" with " + i.horseName + " (Horse)")).font(.system(size:UIScreen.main.bounds.height*0.022))
                                    }
   
                                }.frame(width: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                            }
                        }
                    }.onAppear(){eventViewModel.fetchAllData()}.frame(width: UIScreen.main.bounds.width * 0.8).padding().background(Color(red: 240/255, green: 248/255, blue: 255/255, opacity: 1.0))
                }
                MenuView()
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
