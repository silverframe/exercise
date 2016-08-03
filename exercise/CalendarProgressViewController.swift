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
import CoreGraphics


class CalendarProgressViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    var habit: Habit?
    var date = NSDate()
    var today = NSDate()


    @IBOutlet weak var calendarView1: UIView!
    @IBOutlet weak var calendarHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var weeklyTargetNo: UILabel!
    @IBOutlet weak var totalCompletionsNo: UILabel!
    @IBOutlet weak var longestStreakNo: UILabel!
    @IBOutlet weak var currentStreakNo: UILabel!
    
    var calendarView: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creating the calendar and customizing its appearance
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
        calendarView.appearance.headerTitleColor = UIColor(red: 20/235, green: 205/235, blue: 182/235, alpha: 1.0)
        calendarView.appearance.weekdayTextColor = UIColor(red: 20/235, green: 205/235, blue: 182/235, alpha: 1.0)
        calendarView.appearance.selectionColor = UIColor(red: 20/235, green: 205/235, blue: 182/235, alpha: 1.0)
        
        // Prevents the calendar from being selected by the user 
        if let habit = habit {
        self.title = "Progress"
        for date: Date in habit.dateCompleted {
            calendarView.selectDate(date.date)
            }
        calendarView.allowsSelection = false
        }
        
        calendarView.currentPage = date
        
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")

        
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
    
//    override func viewDidLayoutSubviews() {
//        calendarView = self.view.bounds.size.width
//    }
    
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
    
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        
        // Only allow Portrait
        return UIInterfaceOrientation.Portrait
    }
    
    func calendar(calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.frame = CGRect(origin: calendarView.frame.origin, size: bounds.size)
    }
    

}