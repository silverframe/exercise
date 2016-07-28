//
//  Reset.swift
//  exercise
//
//  Created by Stefanie Seah on 27/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

struct Reset {
    
    let realm = try! Realm()
    func checkReset() {
        let results = realm.objects(Habit)
        for habit: Habit in results {
            let currentWeek = currentWeekValue()
            if habit.week != currentWeek {
                try! Realm().write {
                    habit.week = currentWeek
                    habit.weeklyCompletions = 0
                }
            }
        }
    }
    
    func currentWeekValue() -> Int {
        let todayDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.component(NSCalendarUnit.WeekOfYear, fromDate: todayDate)
        return dateComponents.hashValue
    }
}


