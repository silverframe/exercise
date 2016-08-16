//
//  Habit.swift
//  exercise
//
//  Created by Stefanie Seah on 21/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import RealmSwift
import JSSAlertView

class Habit: Object {
    dynamic var name: String!
    
    //Target number of times for a habit to be completed in a week
    dynamic var weeklyTarget = 0
    
    //Max number of times that a habit can be completed in a week
    dynamic var weekFrequency = 7
    
    dynamic var frequencyPeriod: String = ""
    
    //Total number of times that a habit has been completed
    dynamic var totalCompletions = 0
    
    //Total number of times that a habit has been completed in a week 
    dynamic var weeklyCompletions = 0
    
    dynamic var sortingIndex = 0
    
    dynamic var creationDate: NSDate!
    
    //Current number of straight days in a row that a habit has been completed
    dynamic var currentStreak = 0
    
    //Most number of straight days in a row that a habit has been completed
    dynamic var longestStreak = 0
    
    //To help with the weekly goal reset function
    dynamic var week = 0
    
    dynamic var addToStreak = true
    
    dynamic var uuid: String = NSUUID().UUIDString
    
//    let notificationArray = List<HabitIdentifier>()
    
    let dateCompleted = List<Date>()
    
    dynamic var reminder: Reminder? = Reminder()

    convenience required init(habitName: String, goalFrequency: Int, date: NSDate) {
        self.init()
        name = habitName
        weeklyTarget = goalFrequency
        creationDate = date
    }
    
    func frequencyChange(){
        if weekFrequency == 1 && addToStreak == true {
            try! Realm().write {
                currentStreak = currentStreak + 1
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
                weekFrequency = 0
                let date = Date()
                dateCompleted.insert(date, atIndex: 0)
                addToStreak = false
                
                for notification: UILocalNotification in UIApplication.sharedApplication().scheduledLocalNotifications! {
                    if (notification.userInfo!["uuid"] as! String == uuid) {
                        UIApplication.sharedApplication().cancelLocalNotification(notification)
                    }
                }
            }
            return
        }
        
        if weekFrequency == 0 {
            return
        }
        
        try! Realm().write {
            week = currentWeekValue()
            weekFrequency = weekFrequency - 1
            weeklyCompletions = weeklyCompletions + 1
            totalCompletions = totalCompletions + 1
            currentStreak = currentStreak + 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
            let date = Date()
            dateCompleted.insert(date, atIndex: 0)
        }
    }
    
    func currentWeekValue() -> Int{
        let todayDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.component(NSCalendarUnit.WeekOfYear, fromDate: todayDate)
        return dateComponents.hashValue
    }
    
    func turnReminderOn(){
        if let reminder = reminder {
            if let time = reminder.time {
                addReminder(time)
            }
        }
    }
    
    func turnReminderOff(){
        deleteNotificationsforHabit()
    }
}

extension Habit {
    func addReminder(date: NSDate){
//        let calendar = NSCalendar.currentCalendar()
//        let type: NSCalendarUnit = [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute , NSCalendarUnit.Second , NSCalendarUnit.Weekday]
//        let dateComponent = calendar.components(type, fromDate: date)
//        dateComponent.second = 0
//        let newDate = calendar.dateFromComponents(dateComponent)
//        let firedate = calendar.dateFromComponents(dateComponent)
        
        
//        to clear all other notifications with the UUID
        deleteNotificationsforHabit()
        
        //creating the notification
        let notification = UILocalNotification()
        notification.alertBody = name
        notification.alertAction = "open"
        notification.fireDate = date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.userInfo = ["name": name, "uuid": uuid]
        notification.repeatInterval = .Day
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        print(notification)
    }
    
    func deleteNotificationsforHabit(){
        if let tempArray = UIApplication.sharedApplication().scheduledLocalNotifications {
            for tempNotification in tempArray {
                if let identifier = tempNotification.userInfo!["uuid"] as? String {
                    if identifier == uuid {
                        UIApplication.sharedApplication().cancelLocalNotification(tempNotification)
                        print(tempArray)
                    }
                }
                
            }
        }
    }
}








