//
//  Reminder.swift
//  exercise
//
//  Created by Stefanie Seah on 29/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import RealmSwift

class Reminder: Object {
    
    dynamic var time : NSDate?
    dynamic var reminderOn = false
    
    convenience required init(reminderTime: NSDate, on: Bool) {
        self.init()
        time = reminderTime
        reminderOn = on
    }
}