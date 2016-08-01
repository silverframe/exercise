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

    @IBOutlet weak var calendarView1: UIView!
    
    @IBOutlet weak var weeklyTargetNo: UILabel!
    @IBOutlet weak var totalCompletionsNo: UILabel!
    @IBOutlet weak var longestStreakNo: UILabel!
    @IBOutlet weak var currentStreakNo: UILabel!
    
    var calendarView: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView = FSCalendar()
        calendarView1.addSubview(calendarView)
        calendarView.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        calendarView.delegate = self
        calendarView.dataSource = self

        calendarView.scrollDirection = .Horizontal
        calendarView.allowsMultipleSelection = true
        calendarView.appearance.headerDateFormat = "MMMM"
        calendarView.appearance.cellShape = .Rectangle
        calendarView.clipsToBounds = true
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendarView.appearance.headerTitleColor = UIColor(red: 12/235, green: 203/235, blue: 197/235, alpha: 1.0)
        calendarView.appearance.weekdayTextColor = UIColor(red: 12/235, green: 203/235, blue: 197/235, alpha: 1.0)
        calendarView.appearance.selectionColor = UIColor(red: 12/235, green: 203/235, blue: 197/235, alpha: 1.0)

        if let habit = habit {
        self.title = "Progress"
        for date: Date in habit.dateCompleted {
            calendarView.selectDate(date.date)
            }
        calendarView.allowsSelection = false
        }
        
        calendarView.currentPage = date
        
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