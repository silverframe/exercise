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
    var today = NSDate()

    @IBOutlet weak var calendarView1: FSCalendar!
    
    @IBOutlet weak var weeklyTargetNo: UILabel!
    @IBOutlet weak var totalCompletionsNo: UILabel!
    @IBOutlet weak var longestStreakNo: UILabel!
    @IBOutlet weak var currentStreakNo: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView1 = FSCalendar(frame: CGRect(x: 5, y: 60, width: 310, height: 300))
        calendarView1.delegate = self
        calendarView1.dataSource = self
        view.addSubview(calendarView1)
        self.calendarView1 = calendarView1

        calendarView1.scrollDirection = .Horizontal
        calendarView1.allowsMultipleSelection = true
        calendarView1.appearance.headerDateFormat = "MMMM"
        calendarView1.appearance.cellShape = .Rectangle
        calendarView1.clipsToBounds = true
        calendarView1.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendarView1.appearance.headerTitleColor = UIColor(red: 12/235, green: 203/235, blue: 197/235, alpha: 1.0)
        calendarView1.appearance.weekdayTextColor = UIColor(red: 12/235, green: 203/235, blue: 197/235, alpha: 1.0)
        calendarView1.appearance.selectionColor = UIColor(red: 12/235, green: 203/235, blue: 197/235, alpha: 1.0)

        if let habit = habit {
        self.title = "Progress"
        for date: Date in habit.dateCompleted {
            calendarView1.selectDate(date.date)
            }
        calendarView1.allowsSelection = false
        }
        
        calendarView1.currentPage = date
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habit {
            currentStreakNo.text = String(habit.currentStreak)
            longestStreakNo.text = String(habit.longestStreak)
            weeklyTargetNo.text = "\(habit.weeklyCompletions)/\(habit.weeklyTarget)"
            totalCompletionsNo.text = String(habit.totalCompletions)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "editHabitCal" {
                print("Edit bar button tapped")
                let habit1 = habit
                let habitEntryViewController = segue.destinationViewController as! HabitEntryViewController
                habitEntryViewController.habit = habit1
            }
        }
    }
    

}