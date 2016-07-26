//
//  HabitEntryViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 22/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import RealmSwift
import Foundation

class HabitEntryViewController: UITableViewController {
    
    var habit: Habit?
    
    @IBOutlet weak var habitTextField: UITextField!
    
    @IBOutlet weak var habitFrequencyTextField: UITextField!
    
    @IBOutlet weak var weeklyTargetSlider: UISlider!
    
    @IBAction func weeklyTargetChange(sender: UISlider) {
        let value = Int(sender.value)
        
        if value < 7 {
            habitFrequencyTextField.text = String(value)}
        else { habitFrequencyTextField.text = "Off"}

        
    }
    
    @IBOutlet weak var weeklyCompletionsFigureLabel: UILabel!
    
    @IBOutlet weak var weeklyCompletionsLabel: UILabel!
    
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    @IBOutlet weak var longestStreakLabel: UILabel!
    
    @IBOutlet weak var currentStreakFigure: UITextField!
    
    @IBOutlet weak var longestStreakFigure: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habit {
            habitTextField.text = habit.name
            habitFrequencyTextField.text = String(habit.habitFrequency)
            currentStreakFigure.text = String(habit.currentStreak)
            longestStreakFigure.text = String(habit.longestStreak)
            let habitFrequency = String(habit.habitFrequency)
            weeklyCompletionsFigureLabel.text = "\(habit.completions)/\(habitFrequency)"
            //need to create a weekly completions 
            
        } else {
            habitTextField.text = ""
            habitFrequencyTextField.text = ""
            currentStreakLabel.text = ""
            currentStreakFigure.text = ""
            longestStreakLabel.text = ""
            longestStreakFigure.text = ""
            weeklyCompletionsLabel.text = ""
            weeklyCompletionsFigureLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if habit != nil {
            self.title = habit?.name
        } else {
            self.title = "New Habit"
        }
        
        setUpDefault()
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let habitLogViewController = segue.destinationViewController as! HabitLogViewController

        if segue.identifier == "save" {
            if let habit = habit {
                if (habitTextField.text!.isEmpty || habitFrequencyTextField.text!.isEmpty) {
                    showIncompleteFieldsAlerts()
                }else {
                let newHabit = Habit()
                newHabit.name = habitTextField.text
                newHabit.habitFrequency = Int(weeklyTargetSlider.value)
                    RealmHelper.updateHabit(habit, newHabit: newHabit)}
                
            } else {
                if (habitTextField.text!.isEmpty || habitFrequencyTextField.text!.isEmpty) {
                    showIncompleteFieldsAlerts()
                } else {
                let habit = Habit()
                habit.name = habitTextField.text
                habit.habitFrequency = Int(weeklyTargetSlider.value)
                    RealmHelper.addHabit(habit)}
            }
            habitLogViewController.habits = RealmHelper.retrieveHabits()
        }
    }
    
    func showIncompleteFieldsAlerts () {
        let incompleteAlert = UIAlertController(title: "Oh Snap!", message: "Please fill in the required fields." , preferredStyle: .Alert)
        incompleteAlert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(incompleteAlert, animated: true, completion: nil)}
}

extension HabitEntryViewController {
    func setUpDefault(){
        if let habit = habit {
                weeklyTargetSlider.value = Float(habit.habitFrequency)
            } else {
                weeklyTargetSlider.value = 7
            }
        }
    }