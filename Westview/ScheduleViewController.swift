//
//  ScheduleViewController.swift
//  Westview
//
//  Created by Ronak Shah on 8/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ScheduleViewController.goBack))
        navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
        loadSite()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        
    }
    
    func loadSite() {
        let wrappedUrl = NSURL(string: "http://www2.powayusd.com/pusdwvhs/")
        
        if let url = wrappedUrl {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in //those three vars will be returned from the method
                
                //code here will happen when the task is completed
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    self.parseWebContent(webContent!)
                    //print(self.webContent)
                }
                else {
                    //show error
                }
            }
            task.resume()
        }
        else {
            print("404 Page Not Found")
        }
    }
    
    func parseWebContent(content: NSString) {
        let beginning = "<div id=\"p7tpc1_1\">"
        let end = "<p align=\"justify\">&nbsp;</p>"
        let first = content.componentsSeparatedByString(beginning)
        let second = first[1].componentsSeparatedByString(end)
        print (second[0])

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
