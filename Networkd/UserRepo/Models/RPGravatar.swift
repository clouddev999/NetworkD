//
//  RPGravatar.swift
//  Networkd
//
//  Created by Carlos Rios on 5/10/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation

class RPGravatar {
    var gravatarUrl: String?
    
    class func fromJson(json: [String: AnyObject]?) -> RPGravatar?
    {
        if let validEntry = json?["entry"] as? Array<[String: AnyObject]>, validEntry.count > 0{
            
            let firstEntry = validEntry.first
            
            if let gravatarUrl = firstEntry?["thumbnailUrl"] as? String{
                let newGravatar =  RPGravatar()
                newGravatar.gravatarUrl = gravatarUrl
                return newGravatar
            }
        }
        return nil
    }
    func toNTWGravatar() -> NTWGravatar {
        let newGravatar = NTWGravatar()
        newGravatar.gravatarUrl = self.gravatarUrl
        return newGravatar
    }
}
