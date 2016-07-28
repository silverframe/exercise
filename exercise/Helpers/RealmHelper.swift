//
//  RealmHelper.swift
//  exercise
//
//  Created by Stefanie Seah on 22/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation

//
//  RealmHelper.swift
//  YouTubeAlarm
//
//  Created by Stefanie Seah on 18/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import RealmSwift
import Realm
import UIKit

class RealmHelper {
    static func addHabit(habit: Habit){
        let realm = try! Realm()
        try! realm.write(){
            realm.add(habit)
        }
    }
    
    static func deleteHabit(habit: Habit) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(habit)
        }
    }
    
    static func updateHabit(habitToBeUpdated: Habit, newHabit: Habit) {
        let realm = try! Realm()
        try! realm.write() {
            habitToBeUpdated.name = newHabit.name
            habitToBeUpdated.weeklyTarget = newHabit.weeklyTarget

        }
    }
    
//    static func changeAlarmState(alarmToBeUpdated: Alarm, newAlarmState: Bool) {
//        let realm = try! Realm()
//        try! realm.write() {
//            alarmToBeUpdated.alarmOn = newAlarmState
//            
//        }
//    }
    
    static func updateStreak(habitToBeUpdated: Habit, newHabit: Habit) {
        let realm = try! Realm()
        try! realm.write(){
            habitToBeUpdated.currentStreak = newHabit.currentStreak + 1
            if newHabit.currentStreak > newHabit.longestStreak {
                newHabit.longestStreak = newHabit.currentStreak
            }
            
        }
    }
    
    static func updateStreakFromScratch(habitToBeUpdated: Habit, newHabit: Habit) {
        let realm = try! Realm()
        try! realm.write(){
            newHabit.currentStreak = 0
            if newHabit.currentStreak > newHabit.longestStreak {
                newHabit.longestStreak = newHabit.currentStreak
            }
            
        }
    }
    
    static func resetWeeklyTarget(habitToBeUpdated: Habit, newHabit: Habit) {
        let realm = try! Realm()
        try! realm.write(){
            newHabit.weeklyCompletions = 0
        }
    }
    
    static func retrieveHabits() -> Results<Habit> {
        let realm = try! Realm()
        return realm.objects(Habit)
    }
    
}




