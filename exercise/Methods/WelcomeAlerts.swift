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
    
    static func welcomeAlert1(viewController: HabitLogViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") {
            let welcomeAlert = JSSAlertView().show(viewController, title: "Congratulations",
                                                        text: "You have made the very wise choice to start using this app. I'm so proud of you.",
                                                        buttonText: "OK",
                                                        color: UIColor(red: 20.0/255.0, green: 232.0/255.0, blue: 206.0/255.0, alpha: 1.0))
        }
    }
    
    static func welcomeAlert2(viewController: HabitLogViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") {
            let welcomeAlert = JSSAlertView().show(viewController, title: "Get Started",
                                                   text: "Tap on the + sign at the top right-hand corner to create your first daily habit",
                                                   buttonText: "OK",
                                                   color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))
        }
    }
    
    static func firstHabitAlert(viewController: HabitLogViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") && viewController.habits.count == 1 {
            let firstHabitAlert = JSSAlertView().show(viewController,
                                                           title: "Get Started",
                                                           text: "Tap on the checkbox once you have completed the habit and select the row to check on your progress",
                                                           buttonText: "OK",
                                                           color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))

            firstHabitAlert.addAction(turnOffOnboarding)
        }
    }
    
    static func turnOffOnboarding() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
    }
}


func secondAlert(viewController: HabitLogViewController) {
    WelcomeAlerts.welcomeAlert2(viewController)
}
