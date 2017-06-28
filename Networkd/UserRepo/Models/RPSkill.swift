//
//  RPSkill.swift
//  Networkd
//
//  Created by Cloud Stream on 5/8/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import RealmSwift
class RPSkill: Object{
    
    dynamic var id: String? = nil
    dynamic var title: String? = nil
    class func fromJson(json: [String: AnyObject]?) -> RPSkill?
    {
        if let validJson = json{
            let newInterest = RPSkill()
            newInterest.id = validJson["id"] as? String
            newInterest.title = validJson["title"] as? String
            return newInterest
        }
        return nil
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    func toNTWSkill() -> NTWSkill
    {
        let newSkill = NTWSkill()
        newSkill.id = self.id
        newSkill.title = self.title
        return newSkill
    }
    class func fromNTWSkill(skill:NTWSkill) -> RPSkill
    {
        let newSkill = RPSkill()
        newSkill.id = skill.id
        newSkill.title = skill.title
        return newSkill
    }
}
