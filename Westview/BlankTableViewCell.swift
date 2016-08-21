//
//  BlankTableViewCell.swift
//  Westview
//
//  Created by Ronak Shah on 8/20/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class BlankTableViewCell: UITableViewCell {

    
    @IBOutlet weak var webView: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
