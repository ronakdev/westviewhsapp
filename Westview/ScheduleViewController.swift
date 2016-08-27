//
//  ScheduleViewController.swift
//  Westview
//
//  Created by Ronak Shah on 8/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var navBar: UINavigationItem!
    //@IBOutlet weak var tableView: UITableView!
    var currentDay: [(period: String, start: NSDate, end: NSDate)] = []
    var MF: [(period: String, start: NSDate, end: NSDate)] = []
    var W: [(period: String, start: NSDate, end: NSDate)] = []
    var TT: [(period: String, start: NSDate, end: NSDate)] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scheduleImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //insert back button
        self.navBar.title = "Bell Schedule"
        let backButton = UIBarButtonItem(title: "‹ Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ScheduleViewController.goBack))
        self.navBar.setLeftBarButtonItem(backButton, animated: false)
        
        setupSchedule()
        
        let today = NSDate().day()! - 1
        loadData(today)
        
        

    }

    func setupSchedule() {
        ////Monday Friday
        
        MF.append((period: "Period 1", NSDate(hours: 8, minutes: 5), NSDate(hours: 9, minutes: 33)))
        MF.append((period: "Passing", (MF.last?.end)!, NSDate(hours: 9, minutes: 39)))
        MF.append((period: "Homeroom", (MF.last?.end)!, NSDate(hours: 9, minutes: 54)))
        MF.append((period: "Passing", (MF.last?.end)!, NSDate(hours: 10, minutes: 00)))
        MF.append((period: "Period 2", (MF.last?.end)!, NSDate(hours: 11, minutes: 28)))
        MF.append((period: "Lunch", (MF.last?.end)!, NSDate(hours: 12, minutes: 02)))
        MF.append((period: "Passing", (MF.last?.end)!, NSDate(hours: 12, minutes: 08)))
        MF.append((period: "Period 3", (MF.last?.end)!, NSDate(hours: 1, minutes: 36)))
        MF.append((period: "Passing", (MF.last?.end)!, NSDate(hours: 1, minutes: 42)))
        MF.append((period: "Period 4", (MF.last?.end)!, NSDate(hours: 3, minutes: 10)))
        
        ////Wednesday
        W.append((period: "Period 1", NSDate(hours: 9, minutes: 15), NSDate(hours: 10, minutes: 25)))
        W.append((period: "Passing", (W.last?.end)!, NSDate(hours: 10, minutes: 31)))
        W.append((period: "Homeroom", (W.last?.end)!, NSDate(hours: 10, minutes: 46)))
        W.append((period: "Passing", (W.last?.end)!, NSDate(hours: 10, minutes: 52)))
        W.append((period: "Period 2", (W.last?.end)!, NSDate(hours: 12, minutes: 02)))
        W.append((period: "Lunch", (W.last?.end)!, NSDate(hours: 12, minutes: 38)))
        W.append((period: "Passing", (W.last?.end)!, NSDate(hours: 12, minutes: 44)))
        W.append((period: "Period 3", (W.last?.end)!, NSDate(hours: 1, minutes: 54 )))
        W.append((period: "Passing", (W.last?.end)!, NSDate(hours: 2, minutes: 00)))
        W.append((period: "Period 4", (W.last?.end)!, NSDate(hours: 3, minutes: 10)))
        
        ////Thursday
        
        TT.append((period: "Period 1", NSDate(hours: 8, minutes: 5), NSDate(hours: 9, minutes: 26)))
        TT.append((period: "WT", (TT.last?.end)!, NSDate(hours: 9, minutes: 54)))
        TT.append((period: "Passing", (TT.last?.end)!, NSDate(hours: 10, minutes: 00)))
        TT.append((period: "Period 2", (TT.last?.end)!, NSDate(hours: 11, minutes: 21)))
        TT.append((period: "Lunch", (TT.last?.end)!, NSDate(hours: 11, minutes: 56)))
        TT.append((period: "Passing", (TT.last?.end)!, NSDate(hours: 12, minutes: 02)))
        TT.append((period: "SSR", (TT.last?.end)!, NSDate(hours: 12, minutes: 22)))
        TT.append((period: "Period 3", (TT.last?.end)!, NSDate(hours: 1, minutes: 43)))
        TT.append((period: "Passing", (TT.last?.end)!, NSDate(hours: 1, minutes: 49)))
        TT.append((period: "Period 4", (TT.last?.end)!, NSDate(hours: 3, minutes: 10)))
    }
    
    func loadData(day: Int) {
        switch day {
        case 0,4:
            currentDay = MF
            break
        case 1,3:
            currentDay = TT
            break
        case 2:
            currentDay = W
            break
        default:
            currentDay = MF
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDay.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ScheduleTableViewCell
        cell.loadPeriod(currentDay[indexPath.row])
        
        return cell
    }
    @IBAction func dayChanged(sender: UISegmentedControl) {
        loadData(sender.selectedSegmentIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("homeVC"))!, animated: true, completion: nil)
    }
}
