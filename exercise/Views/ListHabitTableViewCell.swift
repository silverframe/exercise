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
        
        var habitTimes = Int(habitFrequencyLabel.text!)!;
        
        if habitTimes > 0 {
            self.habitFrequencyLabel.text = String(habitTimes - 1) }
        else {
            self.habitFrequencyLabel.text = "Finished"
        }
    }

    

}
