//
//  HabitLogViewController.swift
//  exercise
//
//  Created by Stefanie Seah on 22/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class HabitLogViewController: UITableViewController {
    var habits: Results<Habit>!{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habits = RealmHelper.retrieveHabits()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listHabitTableViewCell", forIndexPath: indexPath) as! ListHabitTableViewCell
        
        let row = indexPath.row
        
        let habit = habits[row]
        
        cell.habitNameLabel.text = habit.name
        
        cell.habitFrequencyLabel.text = String(habit.habitFrequency)
        
        if habit.dateCompleted.count != 0 {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone.defaultTimeZone()
            let date1 = NSDate()
            let date2 = habit.dateCompleted[0].date
            let datesAreInTheSameDay = calendar.isDate(date1, equalToDate: date2, toUnitGranularity: [.Day, .Month, .Year])
            if datesAreInTheSameDay != true {
                cell.habitFrequencyButton.enabled = true
            } else {
                cell.habitFrequencyButton.enabled = false
            }
        } else {
            cell.habitFrequencyButton.enabled = true
        }

        cell.habit = habit
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            RealmHelper.deleteHabit(habits[indexPath.row])
            habits = RealmHelper.retrieveHabits()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "editHabit" {
                print("table cell tapped")
                
                let indexPath = tableView.indexPathForSelectedRow!
                let habit = habits[indexPath.row]
                let editAlarmViewController = segue.destinationViewController as! HabitEntryViewController
                editAlarmViewController.habit = habit
                
            } else if identifier == "addHabit" {
                print("+ button tapped")
            }
        }
    }
    
    @IBAction func unwindToHabitLogViewController(segue: UIStoryboardSegue) {

        
    }
    

    

}
