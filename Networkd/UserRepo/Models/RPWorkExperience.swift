//
//  RPWorkExperience.swift
//  Networkd
//
//  Created by Cloud Stream on 5/8/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import RealmSwift
class RPWorkExperience: Object{
    dynamic var id: String? = nil
    dynamic var title: String? = nil
    dynamic var location: String? = nil
    dynamic var expDescription: String? = nil
    dynamic var company: String? = nil
    dynamic var currentlyHere = true
    dynamic var companyLogo: String? = nil
    dynamic var dateFrom: Date? = nil
    dynamic var dateTo: Date? = nil
    static var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    class func fromJson(json:[String:AnyObject]?) -> RPWorkExperience?
    {
        if let validJson = json{
            let newWE = RPWorkExperience()
            newWE.title = validJson["title"] as? String
            newWE.location = validJson["location"] as? String
            newWE.expDescription = validJson["description"] as? String
            newWE.company = validJson["company"] as? String
            newWE.currentlyHere = validJson["currently_here"] as! Bool
            newWE.id = validJson["id"] as? String
            newWE.companyLogo = validJson["company_logo"] as? String
            
            if let validDate = validJson["date_from"] as? String {
                newWE.dateFrom = self.dateFormatter.date(from: validDate)
            }
            if let validDate = validJson["date_to"] as? String {
                newWE.dateTo = self.dateFormatter.date(from: validDate)
            }
            return newWE
        }
        return nil
    }
    func toNTWWorkExperience() -> NTWWorkExperience
    {
        let newWe = NTWWorkExperience()
        newWe.id = self.id
        newWe.title = self.title
        newWe.location = self.location
        newWe.expDescription = self.expDescription
        newWe.company = self.company
        newWe.currentlyHere = self.currentlyHere
        newWe.companyLogo = self.companyLogo
        newWe.dateFrom = self.dateFrom
        newWe.dateTo = self.dateTo
        return newWe
    }
    class func fromNTWWorkExperience(we:NTWWorkExperience) -> RPWorkExperience
    {
        let newWe = RPWorkExperience()
        newWe.id = we.id
        newWe.title = we.title
        newWe.location = we.location
        newWe.expDescription = we.expDescription
        newWe.company = we.company
        newWe.currentlyHere = we.currentlyHere
        newWe.companyLogo = we.companyLogo
        newWe.dateFrom = we.dateFrom
        newWe.dateTo = we.dateTo
        return newWe
    }

}
