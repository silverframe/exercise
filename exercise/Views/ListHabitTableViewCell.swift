//
//  ListHabitTableViewCell.swift
//  exercise
//
//  Created by Stefanie Seah on 22/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit

class ListHabitTableViewCell: UITableViewCell {
    
    var habit: Habit?
    
//    @IBOutlet weak var habitFrequencyLabel: UILabel!

    @IBOutlet weak var habitFrequencyButton: UIButton!
    
    @IBOutlet weak var habitNameLabel: UILabel!
    
    @IBAction func habitFrequencyButtonClicked(sender: UIButton) {
        if let habit = habit {
            //Changes the no of total completions, current streak, frequency
            habit.frequencyChange()
            if habit.dateCompleted.count != 0 {
            let date = habit.dateCompleted[0].date
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone.defaultTimeZone()
            let datesAreInTheSameDay = calendar.isDateInToday(date)
            if datesAreInTheSameDay != true {
                sender.enabled = true
                
            } else {
                sender.enabled = false
                backgroundColor = UIColor(red: 221/235, green: 221/235, blue: 221/235, alpha: 1.0)
                
                }
            }
            
            
        }
    }
}


