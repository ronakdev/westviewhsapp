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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.backgroundView = UIView(frame: CGRectZero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        announcementTableView.tableFooterView = UIView(frame: CGRectZero)
        // Dispose of any resources that can be recreated.
        //shortcutTableView.registerClass(BlankTableViewCell.self, forCellReuseIdentifier: "blank")
        //announcementTableView.registerClass(BlankTableViewCell.self, forCellReuseIdentifier: "blank")

    }
    
    //MARK: Collection View Functions
    
    /*
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(options[indexPath.row], forIndexPath: indexPath)
    }
     */
    //MARK: TableView Functions
    
    //Section and Row Amounts
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (tableView.tag == SHORTCUT_IDENTIFIER) ? 4 : 1

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView.tag == SHORTCUT_IDENTIFIER) ? 2 : 10
    }
    
    //Filling in cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell : BlankTableViewCell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath) as! BlankTableViewCell
        let cell = announcementTableView.dequeueReusableCellWithIdentifier("blank") as! BlankTableViewCell
        let htmlFile = NSBundle.mainBundle().pathForResource("announcement", ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!, encoding: NSUTF8StringEncoding)
        cell.webView.scrollView.scrollEnabled = false
        cell.webView.scrollView.bounces = false
        cell.webView.loadHTMLString(html!, baseURL: nil)

        return cell
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
}

