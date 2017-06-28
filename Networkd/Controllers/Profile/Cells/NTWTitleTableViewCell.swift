//
//  NTWTitleTableViewCell.swift
//  Networkd
//
//  Created by CloudStream on 5/4/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

protocol NTWTitleCellDelegate: class
{
    func didTapAddButton(atCell cell: UITableViewCell)
}

class NTWTitleTableViewCell: UITableViewCell {
    
    var delegate: NTWTitleCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.didTapAddButton(atCell: self)
    }
    
}
