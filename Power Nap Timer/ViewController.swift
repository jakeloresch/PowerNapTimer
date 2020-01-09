//
//  ViewController.swift
//  Power Nap Timer
//
//  Created by Jake Loresch on 1/20/19.
//  Copyright © 2019 Jake Loresch. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel! //connects countdown
    @IBOutlet weak var timerButton: UIButton! // connects button
    
    var myTimer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        if myTimer.isOn {
          //stop the timer
            myTimer.stopTimer()
        } else {
            //start timer
            myTimer.startTimer(3)
            scheduleLocalAlert(timeInterval: 3)
        }
    }
    
    func updateLabelAndButton() {
        timerLabel.text = myTimer.timeLeftAsString()
        var title = "Start nap"
        if myTimer.isOn {
            title = "Stop"
        }
        timerButton.setTitle(title, for: .normal)
    }

    
    //This was covered right at the hour mark in the video
    func createAlertController() {
        let alert = UIAlertController(title: "Time to wake up", message: "Or is it?", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "I'm up!", style: .default, handler: nil)
        alert.addAction(dismissAction)
        
        let snoozeAction = UIAlertAction(title: "Snooze", style: .destructive) { (_) in
            let textField = alert.textFields?.first
            let timeAsString = textField?.text
            let timeAsDouble = Double(timeAsString!)!
            
            self.myTimer.startTimer(timeAsDouble * 60)
            self.scheduleLocalAlert(timeInterval: timeAsDouble * 60)

        }
        alert.addAction(snoozeAction)
        
        alert.addTextField { (textField) in
            textField.placeholder = "How many more minutes?"
            textField.keyboardType = .numberPad
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func scheduleLocalAlert(timeInterval: TimeInterval){
        
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.subtitle = "subtitle"
        content.body = "body"
        content.badge = 10
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (_) in
            print("User asked to get a local notification")
            
            
        }
    }

}



//myTimer Delegate method
extension ViewController: myTimerDelegate {
    func timerSecondTicked() {
        updateLabelAndButton()
    }
    
    func timerStopped() {
        updateLabelAndButton()
    }
    
    func timerCompleted() {
        updateLabelAndButton()
    }
    
    
}
