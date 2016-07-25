//
//  WeeklyTargetViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 24/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//
import UIKit

class WeeklyTargetViewController: UITableViewController {
    
    var habit: Habit?

    @IBOutlet weak var weeklyTargetFigure: UILabel!
    
    @IBOutlet weak var weeklyTargetSlider: UISlider!
    
    @IBAction func weeklyTargetChange(sender: UISlider) {
        let value = Int(sender.value)
        
        if value < 7 {
            weeklyTargetFigure.text = String(value)}
        else { weeklyTargetFigure.text = "Off"}
        
        habit?.frequency = value 
    }
}
