//
//  TimerViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 12/04/22.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var timer: Timer = Timer()
    
    var timerCounting: Bool = false
    var count: Int = 0
    var ableToChooseProgress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        ableToChooseProgress = false
    }

    @IBAction func startStopAction(_ sender: Any) {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            startStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            if ableToChooseProgress {
                performSegue(withIdentifier: "chooseProgSegue", sender: self)
            }
        } else {
            timerCounting = true
            startStopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
   
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            ableToChooseProgress = true
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        label.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        let hour = seconds / 3600
        let min = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += " : "
        timeString += String(format: "%02d", min)
        timeString += " : "
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    @IBAction func unwindToTimer(_ sender: UIStoryboardSegue) {
        
    }
}
