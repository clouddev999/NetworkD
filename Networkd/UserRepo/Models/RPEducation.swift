//
//  RPEducation.swift
//  Networkd
//
//  Created by Cloud Stream on 5/8/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import RealmSwift
class RPEducation: Object{
    
    dynamic var id: String? = nil
    dynamic var edDescription: String? = nil
    dynamic var degree: String? = nil
    dynamic var institution: String? = nil
    dynamic var averageScore: String? = nil
    dynamic var dateFrom: Date? = nil
    dynamic var dateTo: Date? = nil
    dynamic var universityLogo: String? = nil
    
    static var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(json:[String:AnyObject]?) -> RPEducation?
    {
        if let validJson = json{
            let newEd = RPEducation()
            newEd.edDescription = validJson["description"] as? String
            newEd.degree = validJson["degree"] as? String
            newEd.institution = validJson["institution"] as? String
            newEd.averageScore = validJson["average_score"] as? String
            newEd.id = validJson["id"] as? String
            newEd.universityLogo = validJson["university_logo"] as? String
            
            if let validDate = validJson["date_from"] as? String {
                newEd.dateFrom = self.dateFormatter.date(from: validDate)
            }
            if let validDate = validJson["date_to"] as? String {
                newEd.dateTo = self.dateFormatter.date(from: validDate)
            }
            return newEd
        }
        return nil
    }
    
    func toNTWEducation() -> NTWEducation
    {
        let newEducation = NTWEducation()
        newEducation.id = self.id
        newEducation.edDescription = self.edDescription
        newEducation.institution = self.institution
        newEducation.degree = self.degree
        newEducation.universityLogo = self.universityLogo
        newEducation.averageScore = self.averageScore
        newEducation.dateFrom = self.dateFrom
        newEducation.dateTo = self.dateTo
        return newEducation
    }
    class func fromNTWEducation(education:NTWEducation) -> RPEducation
    {
        let newEducation = RPEducation()
        newEducation.id = education.id
        newEducation.edDescription = education.edDescription
        newEducation.institution = education.institution
        newEducation.averageScore = education.averageScore
        newEducation.dateFrom = education.dateFrom
        newEducation.dateTo = education.dateTo
        return newEducation
    }

}
