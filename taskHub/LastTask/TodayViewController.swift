//
//  TodayViewController.swift
//  LastTask
//
//  Created by Anton on 23.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet var hed: UILabel!
    @IBOutlet var coment: UILabel!
    @IBOutlet var data: UILabel!
    @IBOutlet var status: UILabel!
    @IBAction func goToMyApp(_ sender: UITapGestureRecognizer) {
        let appURL = NSURL(string: "StarterApplication://more")
        extensionContext?.open(appURL! as URL, completionHandler: nil )
    }
    
    private let defaults = UserDefaults(suiteName: "group.myHub")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view from its nib.
        var i = 0
        var cout = 0
        
    let queue = DispatchQueue.global(qos: .default)
        queue.sync {
            while i < (self.defaults?.array(forKey: "arrayHed")!.count)!{
                if self.defaults?.string(forKey: "status"+(self.defaults?.array(forKey: "arrayHed")![i] as! String)) == "В процессе" || self.defaults?.string(forKey: "status"+(self.defaults?.array(forKey: "arrayHed")![i] as! String)) == "Новая"{
                var max: NSDate
                let array = self.defaults?.array(forKey: "arrayDate") as! [String]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
                max = dateFormatter.date(from:array.first!)! as NSDate
                for z in array{
                    let date = dateFormatter.date(from:z)! as NSDate
                    if date.isGreaterThanDate(dateToCompare: max) {
                        max = date
                        cout = i
                    }
                }
            }
            i += 1
        }
        }
        let dateFormatter = DateFormatter()
        defaults?.set(cout, forKey: "coutForToday")
        defaults?.set(false, forKey: "isOpen")
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        data.text = defaults?.array(forKey: "arrayDate")![cout] as? String
        hed.text = defaults?.array(forKey: "arrayHed")![cout] as? String
        coment.text = defaults?.array(forKey: "arrayComent")![cout] as? String
        status.text = defaults?.string(forKey: "status" + (hed.text)!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
