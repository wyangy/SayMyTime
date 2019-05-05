//
//  ViewController.swift
//  SayMyTime
//
//  Created by Wendy Yang on 09/04/2017.
//  Copyright © 2017 wyangy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var playerQueue: AVQueuePlayer!
    
    let hourArray = [["twelve"],
                     ["one"],
                     ["two"],
                     ["three"],
                     ["four"],
                     ["five"],
                     ["six"],
                     ["seven"],
                     ["eight"],
                     ["nine"],
                     ["ten"],
                     ["eleven"],
                     ["twelve"],
                     ["one"],
                     ["two"],
                     ["three"],
                     ["four"],
                     ["five"],
                     ["six"],
                     ["seven"],
                     ["eight"],
                     ["nine"],
                     ["ten"],
                     ["eleven"]
    ]
    
    let minutesArray = [["oclock"],
                        ["o", "one"],
                        ["o", "two"],
                        ["o", "three"],
                        ["o", "four"],
                        ["o", "five"],
                        ["o", "six"],
                        ["o", "seven"],
                        ["o", "eight"],
                        ["o", "nine"],
                        ["o", "ten"],
                        ["eleven"],
                        ["twelve"],
                        ["thirteen"],
                        ["fourteen"],
                        ["fifteen"],
                        ["sixteen"],
                        ["seventeen"],
                        ["eighteen"],
                        ["nineteen"],
                        ["twenty"],
                        ["twenty", "one"],
                        ["twenty", "two"],
                        ["twenty", "three"],
                        ["twenty", "four"],
                        ["twenty", "five"],
                        ["twenty", "six"],
                        ["twenty", "seven"],
                        ["twenty", "eight"],
                        ["twenty", "nine"],
                        ["thirty"],
                        ["thirty", "one"],
                        ["thirty", "two"],
                        ["thirty", "three"],
                        ["thirty", "four"],
                        ["thirty", "five"],
                        ["thirty", "six"],
                        ["thirty", "seven"],
                        ["thirty", "eight"],
                        ["thirty", "nine"],
                        ["forty"],
                        ["forty", "one"],
                        ["forty", "two"],
                        ["forty", "three"],
                        ["forty", "four"],
                        ["forty", "five"],
                        ["forty", "six"],
                        ["forty", "seven"],
                        ["forty", "eight"],
                        ["forty", "nine"],
                        ["fifty"],
                        ["fifty", "one"],
                        ["fifty", "two"],
                        ["fifty", "three"],
                        ["fifty", "four"],
                        ["fifty", "five"],
                        ["fifty", "six"],
                        ["fifty", "seven"],
                        ["fifty", "eight"],
                        ["fifty", "nine"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.main.async {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimeLabel), userInfo: nil, repeats: true)
        }
        
        // Read time at starting the app
        self.readTime()
        
        // Read the time at the beginning of every minute
        var components = NSCalendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: NSDate() as Date)
        
        components.minute! += 1
        components.second = 1
        
        let newDate = NSCalendar.current.date(from: components)!
        
        let timer = Timer(fireAt: newDate, interval: 60, target: self, selector: #selector(self.readTime), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    @objc func updateTimeLabel() {
        timeLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.medium)
    }
    
    @objc func readTime() {
        print("Time now: \(DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.medium))")
        
        let timeString = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
        
        let hourString = timeString.components(separatedBy: ":").first!
        
        var minutesString = timeString.components(separatedBy: ":").last!
        minutesString = String(minutesString.dropLast(3))
        
        let soundsArray = hourArray[Int(hourString)!] + minutesArray[Int(minutesString)!]
        print(soundsArray)
        
        playerQueue = {
            
            var audioItems: [AVPlayerItem] = []
            for audioName in soundsArray {
                let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: audioName, ofType: "mp3")!)
                let item = AVPlayerItem(url: url as URL)
                audioItems.append(item)
            }
            
            let queue = AVQueuePlayer(items: audioItems)
            return queue
        }()
        
        playerQueue.play()
    }
}
