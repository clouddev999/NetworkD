//
//  RPSuccess.swift
//  Networkd
//
//  Created by Cloud Stream on 5/10/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
class RPSuccess{
    var message: String?
    
    class func fromJson(json: [String: AnyObject]?) -> RPSuccess?{
        
        if let validJson = json, let ok = validJson["success"] as? Bool, ok == true{
            let success = RPSuccess()
            success.message = "OK" // always is OK when success is true
            return success
        }
        return nil
    }
    func toNTWSuccess() -> NTWSuccess
    {
        let newNtw = NTWSuccess()
        newNtw.message = self.message
        return newNtw
    }
}
