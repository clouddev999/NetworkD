//
//  File.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/11/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

class MessagesInteractor: NSObject {
    
    static let shared = MessagesInteractor()
    var snackView: SnackBar!
    
    func showSnack(withMessage message: String) {
        let snackView: SnackBar = try! SwiftMessages.viewFromNib()
        snackView.configureContent(body: message)
        snackView.configureTheme(backgroundColor: UIColor.NTWBlue, foregroundColor: .white, iconImage: UIImage(named: "infoIcon"), iconText: nil)
        snackView.titleLabel?.isHidden = true
        snackView.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 1)
        config.shouldAutorotate = true
        config.interactiveHide = true
        
        SwiftMessages.show(config: config, view: snackView)
    }
    
}
