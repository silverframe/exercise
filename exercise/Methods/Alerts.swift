//
//  Alerts.swift
//  exercise
//
//  Created by Stefanie Seah on 3/8/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import JSSAlertView
import UIKit

struct Alert {
    func firstCompletion(viewController: HabitLogViewController){
        let firstCompletionAlert = JSSAlertView().show(
                        viewController,
                        title: "Congrats",
                        text: "You've completed your first ever habit. I am so proud of you.",
                        buttonText: "OK",
                        color: UIColorFromHex(0x14CDB6, alpha: 1)
                        
                    )
        firstCompletionAlert.setTextTheme(.Light)
    }
    
    func firstHabit(viewController: HabitLogViewController){
        let firstHabitAlert = JSSAlertView().show(
            viewController,
            title: "Congrats",
            text: "You've created your first ever habit",
            buttonText: "OK",
            color: UIColorFromHex(0x14CDB6, alpha: 1)
        )
        firstHabitAlert.setTextTheme(.Light)
    }
    
    func streakCompletions(viewController: HabitLogViewController){
        let streakAlert = JSSAlertView().show(
            viewController,
            title: "Congrats",
            text: "Wow! You have reached a \(habit?.currentStreak) day streak",
            buttonText: "OK",
            color: UIColorFromHex(0x14CDB6, alpha: 1)
        )
        streakAlert.setTextTheme(.Light)
    }
}