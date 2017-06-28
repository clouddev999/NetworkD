//
//  File.swift
//  Networkd
//
//  Created by CloudStream on 5/11/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class ProgressInteractor: NSObject {
    
    static let shared = ProgressInteractor()
    var hud: MBProgressHUD!
    
    func showProgress(withMessage message: String, inWindow window: UIWindow) {
        hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.contentColor = UIColor.NTWBlue
        hud.label.text = message
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.textColor = .darkGray
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(hex: 0, alpha: 0.7)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 1.0, alpha: 0.9)
        hud.show(animated: true)
    }
    
    func hideProgress() {
        hud.hide(animated: true)
    }
    
    
}
