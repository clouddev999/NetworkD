//
//  NTWInputTableViewCell2.swift
//  Networkd
//
//  Created by CloudStream on 5/4/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import AnimatedTextInput

@objc protocol NTWInputCellDelegate: class
{
    @objc optional func input(atCell cell: UITableViewCell, didChangeWithText text: String)
    @objc optional func inputShouldBeginEditing(atCell cell: UITableViewCell) -> Bool
}

class NTWInputTableViewCell: UITableViewCell {
    
    var characterLimit: Int!
    var delegate: NTWInputCellDelegate?
    
    @IBOutlet weak var inputTextField: AnimatedTextInput!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.inputTextField.style = NTWTextInputStyle()
        self.inputTextField.delegate = self
        self.inputTextField.type = .standard
        if characterLimit !=  nil {
            self.inputTextField.showCharacterCounterLabel(with: 80)
        }
        
        if self.rightImageView.image == nil {
            self.rightImageView.isHidden = true
        }
    }
}

extension NTWInputTableViewCell: AnimatedTextInputDelegate {
    
    func animatedTextInputDidChange(animatedTextInput: AnimatedTextInput) {
        self.delegate?.input?(atCell: self, didChangeWithText: self.inputTextField.text!)
    }
    
    func animatedTextInputShouldBeginEditing(animatedTextInput: AnimatedTextInput) -> Bool {
        return self.delegate?.inputShouldBeginEditing?(atCell: self) ?? true
    }
    
    func animatedTextInput(animatedTextInput: AnimatedTextInput, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if self.characterLimit != nil {
            let currentString = animatedTextInput.text! as NSString
            let newString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= self.characterLimit
        }
        return true
    }
}
