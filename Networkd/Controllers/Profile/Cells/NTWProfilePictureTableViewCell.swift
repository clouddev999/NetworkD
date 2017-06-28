//
//  NTWProfilePictureTableViewCell.swift
//  Networkd
//
//  Created by CloudStream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

protocol NTWProfilePictureCellDelegate: class
{
    func cell(_ cell: UITableViewCell, editProfilePicture existImage: Bool)
}

class NTWProfilePictureTableViewCell: UITableViewCell {

    weak var delegate: NTWProfilePictureCellDelegate?
    @IBOutlet weak var profilePictureImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func pictureButtonAction(_ sender: Any) {
        self.delegate?.cell(self, editProfilePicture: self.profilePictureImageView.image == nil ? false : true)
    }
    
}
