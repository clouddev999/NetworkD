//
//  String+Extension.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/2/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit

extension String {
    
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
}
