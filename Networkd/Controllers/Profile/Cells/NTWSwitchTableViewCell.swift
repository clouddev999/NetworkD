//
//  NTWSwitchTableViewCell.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/4/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit

protocol NTWSwitchCellDelegate: class
{
    func `switch`(atCell cell: UITableViewCell, didChangeValue isOn: Bool)
}

class NTWSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    var delegate: NTWSwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func switchValueChanges(_ sender: Any) {
        self.delegate?.`switch`(atCell: self, didChangeValue: self.`switch`.isOn)
    }
    

}
