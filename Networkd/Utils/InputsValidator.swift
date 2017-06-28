//
//  File.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/11/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation
import UIKit
import AnimatedTextInput

class InputsValidator: NSObject {
    
    static let shared = InputsValidator()
    
    func areThereEmptyFields(fields: [AnimatedTextInput]) -> Bool {
        var isEmpty = false
        for field in fields {
            if field.text?.trimmingCharacters(in: .whitespaces) == "" {
                isEmpty = true
                return isEmpty
            }
        }
        return isEmpty
    }
    
}
