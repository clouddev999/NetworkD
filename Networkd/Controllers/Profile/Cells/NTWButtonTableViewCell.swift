//
//  NTWSignOutTableViewCell.swift
//  Networkd
//
//  Created by CloudStream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

protocol NTWButtonCellDelegate: class
{
    func didTapButton(atCell cell: UITableViewCell)
}

class NTWButtonTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: NTWButtonCellDelegate?

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var button: UIButton!
    
    
    // MARK: - UITableViewCell Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    // MARK: - IBOutlet Actions
    
    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.didTapButton(atCell: self)
    }
}
