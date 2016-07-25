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
    
    @IBOutlet weak var habitFrequencyLabel: UILabel!

    @IBOutlet weak var habitFrequencyButton: UIButton!
    
    @IBOutlet weak var habitNameLabel: UILabel!
    
    @IBAction func habitFrequencyButtonClicked(sender: UIButton) {
        habit?.frequencyChange()
        self.habitFrequencyLabel.text = String(habit!.frequency)
        let date1 = NSDate()
        let date2 = habit?.dateCompleted[0].date
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        let datesAreInTheSameDay = calendar.isDate(date1, equalToDate: date2!, toUnitGranularity: [.Day, .Month, .Year])
        if datesAreInTheSameDay != true {
            sender.enabled = true
        } else {
            sender.enabled = false
        }
    
    }
}
