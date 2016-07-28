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
    
    @IBOutlet weak var weeklyTargetNo: UILabel!
    @IBOutlet weak var totalCompletionsNo: UILabel!
    @IBOutlet weak var longestStreakNo: UILabel!
    @IBOutlet weak var currentStreakNo: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView1 = FSCalendar(frame: CGRect(x: 0, y: 60, width: 310, height: 300))
        calendarView1.delegate = self
        calendarView1.dataSource = self
        view.addSubview(calendarView1)
        self.calendarView1 = calendarView1

        calendarView1.scrollDirection = .Horizontal
        calendarView1.allowsMultipleSelection = true
        calendarView1.appearance.headerDateFormat = "MMM yy"
        calendarView1.appearance.cellShape = .Circle
        calendarView1.clipsToBounds = true
        
        if let habit = habit {
        for date: Date in habit.dateCompleted {
            calendarView1.selectDate(date.date)
            }
        }
        
        calendarView1.currentPage = date
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habit {
            currentStreakNo.text = String(habit.currentStreak)
            longestStreakNo.text = String(habit.longestStreak)
            weeklyTargetNo.text = "\(habit.completions)/\(habit.habitFrequency)"
            totalCompletionsNo.text = String(habit.completions)
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