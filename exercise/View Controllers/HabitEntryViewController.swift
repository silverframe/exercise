//
//  HabitEntryViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 22/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import RealmSwift
import Foundation

class HabitEntryViewController: UITableViewController, UITextFieldDelegate {
    
    var habit: Habit?
    
    @IBOutlet weak var habitTextField: UITextField!
    
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    var pickerVisible = false
    @IBAction func reminderToggle(sender: UISwitch) {

        if sender.on {
            pickerVisible = true
            print("on")
        } else {
            pickerVisible = false
            print("off")
        }
        tableView.reloadData()
    }
    @IBOutlet weak var reminderTimeLabel: UILabel!
    
    @IBOutlet weak var reminderTimePicker: UIDatePicker!
    
    @IBAction func reminderTimeChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        reminderTimeLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBOutlet weak var weeklyTargetSlider: UISlider!
    
    @IBOutlet weak var weeklyTargetFigure: UILabel!
    
    @IBAction func weeklyTargetChange(sender: UISlider) {
        let value = Int(sender.value)
        
        if value < 7 {
            weeklyTargetFigure.text = String(value)}
        else { weeklyTargetFigure.text = "Off"}

    }
    
    @IBOutlet weak var weeklyCompletionsFigureLabel: UILabel!
    
    @IBOutlet weak var totalCompletionsFigure: UILabel!
    @IBOutlet weak var longestStreakFigure: UILabel!
    
    @IBOutlet weak var currentStreakFigure: UILabel!
    
    @IBOutlet weak var weeklyCompletionsLabel: UILabel!
    
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    @IBOutlet weak var longestStreakLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habit {
            habitTextField.text = habit.name
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
            if let date = habit.reminder.time {
                self.reminderTimeLabel.text = dateFormatter.stringFromDate(date)
            } else {
                self.reminderTimeLabel.text = ""
            }
            weeklyTargetFigure.text = String(habit.weeklyTarget)
            currentStreakFigure.text = String(habit.currentStreak)
            longestStreakFigure.text = String(habit.longestStreak)
            reminderSwitch.on = habit.reminder.reminderOn
            let weeklyTarget = String(habit.weeklyTarget)
            weeklyCompletionsFigureLabel.text = "\(habit.weeklyCompletions)/\(weeklyTarget)"
            totalCompletionsFigure.text = String(habit.totalCompletions)
            //need to create a weekly completions
            
        } else {
            habitTextField.text = ""
            reminderTimeLabel.text = ""
            weeklyTargetFigure.text = "7"
            currentStreakLabel.text = ""
            currentStreakFigure.text = ""
            longestStreakLabel.text = ""
            longestStreakFigure.text = ""
            weeklyCompletionsLabel.text = ""
            weeklyCompletionsFigureLabel.text = ""
            reminderSwitch.on = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitTextField.delegate = self
        if let habit = habit {
            self.title = habit.name
            
            //For updating the streak function
            if habit.dateCompleted.count != 0 {
            let date2 = habit.dateCompleted[0].date
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone.defaultTimeZone()
            let datesAreInTheSameDay = calendar.isDateInToday(date2)
            let dateIstheDayBefore = calendar.isDateInYesterday(date2)
            //look over this tomorrow
            if (datesAreInTheSameDay || dateIstheDayBefore) != true {
                RealmHelper.updateStreakFromScratch(habit, newHabit: habit)}
            }
        } else {
            self.title = "New Habit"
        }
        
        setUpDefault()
    }
    
    // better look over very carefully 
    

    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            if pickerVisible {
                return 165.0
            } else {
                return 0.0
            }
        }
        
        if indexPath.row == 4 {
            return 75.0
        }
        
        return 44.0
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        if segue.identifier == "save" {
            let habitLogViewController = segue.destinationViewController as! HabitLogViewController
       
            if let habit = habit {
                if (habitTextField.text!.isEmpty) {
                    showIncompleteFieldsAlerts()
                }else {
                let newHabit = Habit()
                newHabit.name = habitTextField.text
                newHabit.reminder.time = reminderTimePicker.date
                newHabit.reminder.reminderOn = reminderSwitch.on
                newHabit.weeklyTarget = Int(weeklyTargetSlider.value)
                    RealmHelper.updateHabit(habit, newHabit: newHabit)}
                
            } else {
                if (habitTextField.text!.isEmpty) {
                    showIncompleteFieldsAlerts()
                } else {
                let habit = Habit()
                habit.name = habitTextField.text
                habit.reminder.time = reminderTimePicker.date
                habit.reminder.reminderOn = reminderSwitch.on
                habit.weeklyTarget = Int(weeklyTargetSlider.value)
                habit.week = habit.currentWeekValue()
                    RealmHelper.addHabit(habit)}
            }
            habitLogViewController.habits = RealmHelper.retrieveHabits()
        } else if segue.identifier == "getReminder" {
            print("reminder tapped")
            let habit1 = habit
            let editReminderViewController = segue.destinationViewController as! EditReminderViewController
            editReminderViewController.habit = habit1 
        
        }
    }
    
    func showIncompleteFieldsAlerts () {
        let incompleteAlert = UIAlertController(title: "Oh Snap!", message: "Please fill in the required fields." , preferredStyle: .Alert)
        incompleteAlert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(incompleteAlert, animated: true, completion: nil)}
    
    @IBAction func unwindToHabitEntryViewController(segue: UIStoryboardSegue) {
        
        
    }
    
}

extension HabitEntryViewController {
    func setUpDefault(){
        if let habit = habit {
                weeklyTargetSlider.value = Float(habit.weeklyTarget)
            } else {
                weeklyTargetSlider.value = 7
            }
        }
    }