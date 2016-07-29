//
//  EditReminderViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 29/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit
import RealmSwift

class EditReminderViewController: UIViewController {
    
    var habit: Habit?
    
    @IBOutlet weak var reminderTimePicker: UIDatePicker!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpDefault()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if habit?.reminder != nil {
            self.title = "Edit Reminder"
        } else {
            self.title = "New Reminder"
        }
        
        setUpDefault()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveReminder" {
            let destinationViewController = segue.destinationViewController as! HabitEntryViewController
            
            if let habit = habit {
                print("save tapped")
                let newHabit = Habit()
                newHabit.name = habit.name
                newHabit.weeklyTarget = habit.weeklyTarget
                newHabit.reminder.time = reminderTimePicker.date
                newHabit.reminder.reminderOn = false
                RealmHelper.updateHabit(habit, newHabit: newHabit)
                
            }
            else {
                destinationViewController.habit?.reminder.time = reminderTimePicker.date
            }
        } else if segue.identifier == "cancelReminder"{
            
            print("cancel tapped")
            
        }
        let habit1 = habit
        let habitEntryViewController = segue.destinationViewController as! HabitEntryViewController
        habitEntryViewController.habit = habit1
    }
    
    func getReminderTime() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        return dateFormatter.stringFromDate(reminderTimePicker.date)
        
    }
}

extension EditReminderViewController {
    
    func setUpDefault(){
        if let habit = habit {
            if let time = habit.reminder.time {
                reminderTimePicker.date = time
            } else {
                reminderTimePicker.date = NSDate()
            }
        }
    }
}


