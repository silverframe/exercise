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
            habitToBeUpdated.frequency = newHabit.frequency
            habitToBeUpdated.frequencyPeriod = newHabit.frequencyPeriod
        }
    }
    
//    static func changeAlarmState(alarmToBeUpdated: Alarm, newAlarmState: Bool) {
//        let realm = try! Realm()
//        try! realm.write() {
//            alarmToBeUpdated.alarmOn = newAlarmState
//            
//        }
//    }
    
//    static func updateFrequency(habitToBeUpdated: Habit, habitFrequency: Int) {
//        let realm = try! Realm()
//        try! realm.write(){
//            habitToBeUpdated.frequency =
//        }
//    }
    
    static func retrieveHabits() -> Results<Habit> {
        let realm = try! Realm()
        return realm.objects(Habit)
    }
    
}




