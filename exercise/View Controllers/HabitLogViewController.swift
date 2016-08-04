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
    
    @IBAction func swipeRight(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habits = RealmHelper.retrieveHabits()
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: #selector(self.reloadTable), name: "EnterForeground", object: nil)
        self.setNeedsStatusBarAppearanceUpdate()
        WelcomeAlerts.welcomeAlert(self)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        WelcomeAlerts.firstHabitAlert(self)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listHabitTableViewCell", forIndexPath: indexPath) as! ListHabitTableViewCell
        
        let row = indexPath.row
        
        let habit = habits[row]
        
        cell.habitNameLabel.text = habit.name
        
        cell.delegate = self
    
        // Function to differentiate between a newly created habit(during the same session) and an existing one
        if habit.dateCompleted.count != 0 {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone.defaultTimeZone()
            let date2 = habit.dateCompleted[0].date
            let datesAreInTheSameDay = calendar.isDateInToday(date2)
            if datesAreInTheSameDay {
                cell.habitFrequencyButton.enabled = false
                cell.backgroundColor = UIColor(red: 221/235, green: 221/235, blue: 221/235, alpha: 1.0)
                cell.habitNameLabel.alpha = 0.2
                
            } else {
                cell.habitFrequencyButton.enabled = true
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
            if identifier == "showCalCell" {
                print("table cell tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let habit = habits[indexPath.row]
                let calendarProgressViewController = segue.destinationViewController as! CalendarProgressViewController
               calendarProgressViewController.habit = habit
            } else if identifier == "addHabit" {
                print("+ button tapped")
            } else if identifier == "showCal" {

            }
        }
    }
    
    @IBAction func unwindToHabitLogViewController(segue: UIStoryboardSegue) {

        
    }
    

    

}


extension HabitLogViewController: ModalAlertDelegate{
    func showAlert(string:String){
//            Alert().streakCompletions(self)
    }
}





