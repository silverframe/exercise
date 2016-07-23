//
//  HabitEntryViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 22/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import RealmSwift

class HabitEntryViewController: UITableViewController {
    

    
    @IBOutlet weak var habitTextField: UITextField!

    
    @IBOutlet weak var habitFrequencyTextField: UITextField!
    
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    @IBOutlet weak var longestStreakLabel: UILabel!
    
    @IBOutlet weak var currentStreakFigure: UITextField!
    var habit: Habit?
    
    @IBOutlet weak var longestStreakFigure: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habit {
            habitTextField.text = habit.name
            habitFrequencyTextField.text = String(habit.frequency)
            currentStreakFigure.text = String(habit.currentStreak)
            longestStreakFigure.text = String(habit.longestStreak)
            
        } else {
            habitTextField.text = ""
            habitFrequencyTextField.text = ""
            currentStreakLabel.text = ""
            currentStreakFigure.text = ""
            longestStreakLabel.text = ""
            longestStreakFigure.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if habit != nil {
            self.title = habit?.name
        } else {
            self.title = "New Habit"
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let habitLogViewController = segue.destinationViewController as! HabitLogViewController
        if segue.identifier == "save" {
            if let habit = habit {
                let newHabit = Habit()
                newHabit.name = habitTextField.text
                newHabit.frequency = Int(habitFrequencyTextField.text!)!
                RealmHelper.updateHabit(habit, newHabit: newHabit)
            } else {
                let habit = Habit()
                habit.name = habitTextField.text
                habit.frequency = Int(habitFrequencyTextField.text!)!
                RealmHelper.addHabit(habit)
            }
            habitLogViewController.habits = RealmHelper.retrieveHabits()
        }
    }
}
