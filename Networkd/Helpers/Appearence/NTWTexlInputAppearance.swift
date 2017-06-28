//
//  NTWTexlInputAppearance.swift
//  Networkd
//
//  Created by CloudStream on 5/10/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import UIKit
import AnimatedTextInput

struct NTWTextInputStyle: AnimatedTextInputStyle {
    let activeColor = UIColor.NTWBlue
    let inactiveColor = UIColor.NTWGray
    let lineInactiveColor = UIColor.NTWGray
    let errorColor = UIColor.red
    let textInputFont = UIFont.systemFont(ofSize: 15)
    let textInputFontColor = UIColor.black
    let placeholderMinFontSize: CGFloat = 13
    let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 10)
    let leftMargin: CGFloat = 0
    let topMargin: CGFloat = 25
    let rightMargin: CGFloat = 0
    let bottomMargin: CGFloat = 5
    let yHintPositionOffset: CGFloat = 7
    let yPlaceholderPositionOffset: CGFloat = 0
    public let textAttributes: [String: Any]? = nil
}
