//
//  RPInterest.swift
//  Networkd
//
//  Created by Carlos Rios on 5/8/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation
import RealmSwift
class RPInterest: Object{
    
    dynamic var id: String? = nil
    dynamic var title: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(json: [String: AnyObject]?) -> RPInterest?
    {
        if let validJson = json{
            let newInterest = RPInterest()
            newInterest.id = validJson["id"] as? String
            newInterest.title = validJson["title"] as? String
            return newInterest
        }
        return nil
    }
    func toNTWInterest() -> NTWInterest
    {
        let newInterest = NTWInterest()
        newInterest.id = self.id
        newInterest.title = self.title
        return newInterest
    }
    class func fromNTWInterest(interest:NTWInterest) -> RPInterest
    {
        let newInterest = RPInterest()
        newInterest.id = interest.id
        newInterest.title = interest.title
        return newInterest
    }

}
