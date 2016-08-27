//
//  ScheduleTableViewCell.swift
//  Westview
//
//  Created by Ronak Shah on 8/21/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var periodNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadPeriod(p: (period: String, start: NSDate, end: NSDate)) {
        periodNameLabel.text! = p.period
        
        let start = p.start.clockTime()
        let end = p.end.clockTime()
        
        startTimeLabel.text! = start
        endTimeLabel.text! = end
    }

}
