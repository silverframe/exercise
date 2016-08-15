//
//  HabitIdentifier.swift
//  Habitual
//
//  Created by Stefanie Seah on 15/8/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import RealmSwift

class HabitIdentifier: Object {
    
    private(set) dynamic var uuid = NSUUID().UUIDString
    
}
