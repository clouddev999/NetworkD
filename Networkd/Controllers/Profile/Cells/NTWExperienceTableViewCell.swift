//
//  NTWExperienceTableViewCell.swift
//  Networkd
//
//  Created by CloudStream on 5/4/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

/*protocol NTWInputCellDelegate: class
{
    optional func swicth(atCell cell: UITableViewCell, didChangeValue isOn: Bool)
}*/

class NTWExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
