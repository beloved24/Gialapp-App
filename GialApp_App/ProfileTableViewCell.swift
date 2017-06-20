//
//  ProfileTableViewCell.swift
//  GialApp_App
//
//  Created by Antonio Romaniello on 20/06/2017.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
    }

}
