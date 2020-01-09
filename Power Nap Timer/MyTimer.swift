//
//  MyTimer.swift
//  Power Nap Timer
//
//  Created by Jake Loresch on 1/20/19.
//  Copyright © 2019 Jake Loresch. All rights reserved.
//

import Foundation

protocol myTimerDelegate: class {
    func timerSecondTicked()
    func timerStopped()
    func timerCompleted()
}

class MyTimer {
    var timer: Timer?
    
    weak var delegate: myTimerDelegate?
    
    //time left
    var timeLeft: TimeInterval?
    
    //timer is on
    
    var isOn: Bool {
        if timeLeft == nil {
            return false
        } else {
            return true
        }
    }
    
    
    //func start timer
    func startTimer(_ time: TimeInterval){
        print("timer started")
        if isOn {
            //do nothing
            print("Mistake was made, timer should not be running")
        } else {
            timeLeft = time
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                self.secondTicked()
            })
        }
    }
    
    //func stop timer
    func stopTimer() {
        self.timeLeft = nil
        timer?.invalidate()
        print("Stop timer")
        delegate?.timerStopped()
    }
    
    
    //time left as string

    func timeLeftAsString() -> String {
        let timeRemaining = Int(self.timeLeft ?? 20 * 60)
        let minutesLeft = timeRemaining / 60
        let secondsLeft = timeRemaining - (minutesLeft * 60)
        return String(format: " %02d : %02d ", arguments: [minutesLeft, secondsLeft])
    }
    
    //private method that determines what happens when a second tickes by
    
    func secondTicked() {
        //check time left, if any reduce by one, then stop timer
        
        guard let timeLeft = timeLeft else {
            return
        }
        
        // reduce time left by one second
        
        if timeLeft > 0 {
            self.timeLeft = timeLeft - 1
            print(self.timeLeftAsString())
            delegate?.timerSecondTicked()
            
        } else {
            //stop the timer because it is finished
            self.timeLeft = nil
            timer?.invalidate()
            print("Stop timer")
            delegate?.timerStopped()
        }
    }
    
}
