//
//  Habit.swift
//  exercise
//
//  Created by Stefanie Seah on 21/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import RealmSwift

class Habit: Object {
    dynamic var name: String!
    dynamic var habitFrequency = 0
    dynamic var frequency = 0
    dynamic var frequencyPeriod: String = ""
    dynamic var weeklyTarget = 0
    dynamic var sortingIndex = 0
    dynamic var creationDate: NSDate!
    dynamic var currentStreak = 0
    dynamic var longestStreak = 0
    dynamic var addToStreak = true
    dynamic var uuid = NSUUID().UUIDString
    let dateCompleted = List<Date>()

    convenience required init(habitName: String, goalFrequency: Int, date: NSDate) {
        self.init()
        name = habitName
        habitFrequency = goalFrequency
        creationDate = date
    }
    
    
    func frequencyChange(){
        if frequency == 1 && addToStreak == true {
            try! Realm().write {
                currentStreak = currentStreak + 1
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
                frequency = 0
                let date = Date()
                dateCompleted.insert(date, atIndex: 0)
                addToStreak = false
                
                for notification: UILocalNotification in UIApplication.sharedApplication().scheduledLocalNotifications! {
                    if (notification.userInfo!["UUID"] as! String == uuid) {
                        UIApplication.sharedApplication().cancelLocalNotification(notification)
                    }
                }
            }
            return
        }
        
        if frequency == 0 {
            return
        }
        
        try! Realm().write {
            frequency = frequency - 1
            let date = Date()
            dateCompleted.insert(date, atIndex: 0)
            
        }
    }
}   
    





