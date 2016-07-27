//
//  CalendarProgressViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 20/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import EventKit
import UIKit
import CVCalendar

class CalendarProgressViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    var habit: Habit? 
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    @IBOutlet weak var calendarView: CVCalendarView!
    
    
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        menuView.delegate = self
//        calendarView.delegate = self
//        
//        menuView.commitMenuViewUpdate()
//        calendarView.commitCalendarViewUpdate()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.delegate = self
        calendarView.delegate = self
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
        
        for date: Date in habit!.dateCompleted {
            calendarView.(date.date)
        }

        
    }
    
    
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = CVCalendarManager.self
        let components = calendarManager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        components.day = 4 // CVCalendar will select this day view
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
        self.calendarView.changeDaysOutShowingState(true)
        self.calendarView.shouldShowWeekdaysOut
        self.title = String(components.month)
        
    }
    

    
}