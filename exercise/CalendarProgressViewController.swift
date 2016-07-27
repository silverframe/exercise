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
import FSCalendar

class CalendarProgressViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    var habit: Habit?
    var date = NSDate()

    @IBOutlet weak var calendarView1: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView1 = FSCalendar(frame: CGRect(x: 0, y: 60, width: 320, height: 300))
        calendarView1.delegate = self
        calendarView1.dataSource = self
        view.addSubview(calendarView1)
        self.calendarView1 = calendarView1

        calendarView1.scrollDirection = .Horizontal
        calendarView1.allowsMultipleSelection = true
        calendarView1.appearance.headerDateFormat = "MMM yy"
        calendarView1.appearance.cellStyle = .Rectangle
        calendarView1.clipsToBounds = true
        
        if let habit = habit {
        for date: Date in habit.dateCompleted {
            calendarView1.selectDate(date.date)
            }
        }
        
        calendarView1.currentPage = date
        
    }
    
    
}