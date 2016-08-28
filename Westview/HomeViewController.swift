//
//  HomeViewController.swift
//  Westview
//
//  Created by Ronak Shah on 8/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let SHORTCUT_IDENTIFIER = 0
    let ANNOUNCEMENT_IDENTIFIER = 1
    
    @IBOutlet weak var announcementTableView: UITableView!
    var options = ["Schedule", "Calendar", "Grades", "My Connect", "Handbook", "Attendance", "Website", "Social"]
    var color = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    //collection view
    var cellsAcross = 4
    var cellsDown = 2
    var horizGap = 4
    var vertGap = 4
    
    var announcements = [Announcement]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.backgroundView = UIView(frame: CGRectZero)
        loadAnnouncements()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        announcementTableView.tableFooterView = UIView(frame: CGRectZero)
        // Dispose of any resources that can be recreated.
        //shortcutTableView.registerClass(BlankTableViewCell.self, forCellReuseIdentifier: "blank")
        //announcementTableView.registerClass(BlankTableViewCell.self, forCellReuseIdentifier: "blank")
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            cellsAcross = 8
            cellsDown = 1
        } else {
            cellsAcross = 4
            cellsDown = 2
        }
    }
    
    //MARK: Loading Shortcuts (UICollectionView Functions)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsAcross * cellsDown
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(vertGap)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Image", forIndexPath: indexPath) as! ImageCollectionViewCell
        let image = UIImage(named: options[indexPath.row])
        cell.btn.setImage(image, forState: .Normal)
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(HomeViewController.shortcutPressed(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func shortcutPressed(sender: UIButton!) {
        let target = options[sender.tag]
        
        if target == "Schedule" {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("schedule")
            self.presentViewController(vc!, animated: true, completion: nil)
        }
        else if target == "Calendar" {
            openLink("http://www2.powayusd.com/pusdwvhs/calendar.shtml")
        }
        else if target == "Grades" {
            openLink("https://sis.powayusd.com/Login_Student_PXP.aspx")
        }
        else if target == "My Connect" {
            openLink("https://poway.instructure.com")
        }
        else if target == "Handbook" {
            print("functionality not yet supported")
        }
        else if target == "Attendance" {
            print("functionality not yet supported")
        }
        else if target == "Website"{
            openLink("http://www2.powayusd.com/pusdwvhs/")
        }
        else if target == "Social" {
            print("functionality not yet supported")
        }
        
    }
    
    func openLink(link: String) {
        UIApplication.sharedApplication().openURL(NSURL(string: link)!)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(horizGap)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Compute the dimensions of a cell for a cellsAcross x cellsDown layout.
        
        let dimH = (collectionView.bounds.width - (CGFloat(cellsAcross) - 1) * CGFloat(horizGap)) / CGFloat(cellsAcross)
        
        let dimV = (collectionView.bounds.height - (CGFloat(cellsDown) - 1) * CGFloat(vertGap)) / CGFloat(cellsDown)
        
        return CGSize(width: dimH, height: dimV)
    }
    
    //MARK: Loading Announcements
    
    //MARK: UITableView Functions
    
    // Row Amounts
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (announcements.count == 0) ? 1: announcements.count
    }
    
    //Filling in cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell : BlankTableViewCell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath) as! BlankTableViewCell
        if announcements.count == 0 {
            let cell = announcementTableView.dequeueReusableCellWithIdentifier("notloaded")
            return cell!
        }
        else {
            
            let cell = announcementTableView.dequeueReusableCellWithIdentifier("blank") as! BlankTableViewCell
            let announcement = announcements[indexPath.row]
            cell.webView.scrollView.scrollEnabled = false
            cell.webView.scrollView.bounces = false
            cell.webView.loadHTMLString(announcement.htmlContent, baseURL: nil)
            
            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //MARK: WebView Functions
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.LinkClicked {
            
            UIApplication.sharedApplication().openURL(request.URL!)
            return false
        }
        return true
    }
    
    //MARK: Announcement Loading Functions
    
    func loadAnnouncements() {
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
        var announcementStrings = second[0].componentsSeparatedByString("<p class=\"event\">")
        for j in 0..<announcementStrings.count {
            announcementStrings[j] = "<p class=\"event\">" + announcementStrings[j]
            let styling = "<style>@import url(https://fonts.googleapis.com/css?family=Lato|Oswald);body{text-align:center;}img{display:none}.event{font-size:2em;font-family:Oswald,sans-serif}.event_message{font-size:1.1em;font-family:Lato,sans-serif}</style>"
            announcementStrings[j] = styling + announcementStrings[j]
            announcementStrings[j] += "<script>var as=document.getElementsByTagName(\"a\");console.log(as);for(var j=0;j<as.length;j++){if(as[j].href.substring(0,4)==\"http\"||as[j].href.substring(0,3)==\"www\"){}else{var str=as[j].href;var first=str.split(\"applewebdata://\");var res=first[1].split(\"/\");var finalStr=\"http://www2.powayusd.com/pusdwvhs/\"+res[1]as[j].href=finalStr console.log(as[j].href)}}</script>"
            let str = announcementStrings[j]
            let coms = str.componentsSeparatedByString("<a href=\"")
            let insert = "<a href=\"http://www2.powayusd.com/pusdwvhs/"
            var final = ""
            var first = false
            var index=0
            for s in coms {
                final += s
                if (index == 0) {
                    index = 1
                    first = true
                }
                if (coms[index - 1][0..<3] == "http") {
                    final += "<a href=\""
                }
                else {
                    final += insert
                }
                if first {
                    first = false
                    index = 0
                }
                index += 1
                
            }
            
            announcementStrings[j] = final
            
            announcements.append(Announcement(content: announcementStrings[j]))
        }
        print(announcements[4].htmlContent)
        announcements.removeFirst()
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.announcementTableView.reloadData()
        })
    }
    
    
}

