//
//  WelcomeAlerts.swift
//  exercise
//
//  Created by Stefanie Seah on 3/8/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import Foundation
import UIKit
import JSSAlertView

struct WelcomeAlerts {
    
    static func welcomeAlert(viewController: HabitLogViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") {
            let welcomeAlert = JSSAlertView().show(viewController, title: "Welcome to Habitual!",
                                                        text: "Tap on the + sign in the top right-hand corner to create your first habit",
                                                        buttonText: "OK",
                                                        color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))
        }
    }
    
    static func firstHabitAlert(viewController: HabitLogViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") && viewController.habits.count == 1 {
            let firstHabitAlert = JSSAlertView().show(viewController,
                                                           title: "Form good habits!",
                                                           text: "Tap on the checkbox once you have completed the habit",
                                                           buttonText: "OK",
                                                           color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))

            firstHabitAlert.addAction(turnOffOnboarding)
        }
    }
    
    static func turnOffOnboarding() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
    }
}
