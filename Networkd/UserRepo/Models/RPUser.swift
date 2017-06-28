//
//  RPUser.swift
//  Networkd
//
//  Created by Carlos Rios on 5/7/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation
import RealmSwift
class RPUser: Object {
    dynamic var id:String? = nil
    dynamic var firstName:String? = nil
    dynamic var lastName:String? = nil
    dynamic var position:String? = nil
    dynamic var company:String? = nil
    dynamic var industry:String? = nil
    dynamic var location:String? = nil
    dynamic var school:String? = nil
    dynamic var degree:String? = nil
    dynamic var forHire = true
    dynamic var token:String? = nil
    dynamic var about:String? = nil
    dynamic var email:String? = nil
    dynamic var avatar:String? = nil
    let  workExperiences = List<RPWorkExperience>()
    let  educations = List<RPEducation>()
    let  interests = List<RPInterest>()
    let  skills = List<RPSkill>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func fromJson(_ serialized: [String: AnyObject]?) -> RPUser?
    {
        if let validJson = serialized{
            let newUser = RPUser()
            if let validData = validJson["data"] as? [String: AnyObject]{
                newUser.id = validData["id"] as? String
                newUser.firstName = validData["first_name"] as? String
                newUser.lastName = validData["last_name"] as? String
                newUser.position = validData["position"] as? String
                newUser.company = validData["company"] as? String
                newUser.industry = validData["industry"] as? String
                newUser.location = validData["location"] as? String
                newUser.school = validData["school"] as? String
                newUser.degree = validData["degree"] as? String
                newUser.forHire = validData["for_hire"] as! Bool
                newUser.token = validData["token"] as? String
                newUser.about = validData["about"] as? String
                newUser.email = validData["email"] as? String
                newUser.avatar = validData["avatar"] as? String
                
                // deserialized workExperiences
                if let validWE = validData["work_experiences"]! as? Array<[String: AnyObject]>{
                    for wk in validWE {
                        if let newWK = RPWorkExperience.fromJson(json: wk){
                            newUser.workExperiences.append(newWK)
                        }
                    }
                }
                // deserialized educations
                if let validEd = validData["studies"]! as? Array<[String: AnyObject]>{
                    for ed in validEd {
                        if let newEd = RPEducation.fromJson(json: ed){
                            newUser.educations.append(newEd)
                        }
                    }
                }
                // deserialized interests
                if let validInterests = validData["interests"]! as? Array<[String: AnyObject]>{
                    for interest in validInterests {
                        if let newInterest = RPInterest.fromJson(json: interest){
                            newUser.interests.append(newInterest)
                        }
                    }
                }
                // deserialized interests
                if let validSkills = validData["skills"]! as? Array<[String: AnyObject]>{
                    for skill in validSkills {
                        if let newInterest = RPSkill.fromJson(json: skill){
                            newUser.skills.append(newInterest)
                        }
                    }
                }
                return newUser;
            }
        }
        return nil
    }
    func toNTWUser() -> NTWUser
    {
        let newNTWUser = NTWUser()
         newNTWUser.id = self.id
        newNTWUser.email = self.email
        newNTWUser.firstName = self.firstName
        newNTWUser.lastName = self.lastName
        newNTWUser.avatar = self.avatar
        newNTWUser.position = self.position
        newNTWUser.company = self.company
        newNTWUser.industry = self.industry
        newNTWUser.location = self.location
        newNTWUser.school = self.school
        newNTWUser.degree = self.degree
        newNTWUser.forHire = self.forHire
        newNTWUser.token = self.token
        newNTWUser.about = self.about
        
        // convert work experiences
        for rpWe in self.workExperiences{
            newNTWUser.workExperiences.append(rpWe.toNTWWorkExperience())
            
        }
        // convert educations
        for ed in self.educations{
            newNTWUser.educations.append(ed.toNTWEducation())
        }
        // convert interests
        for interest in self.interests{
            newNTWUser.interests.append(interest.toNTWInterest())
        }
        
        // convert skills
        for skill in self.skills{
            newNTWUser.skills.append(skill.toNTWSkill())
        }
        return newNTWUser
    }
    class func fromNTWUser(user: NTWUser) -> RPUser
    {
        let rpUser = RPUser()
        rpUser.id = user.id
        rpUser.email = user.email
        rpUser.firstName = user.firstName
        rpUser.firstName = user.lastName
        rpUser.avatar = user.avatar
        rpUser.position = user.position
        rpUser.company = user.company
        rpUser.industry = user.industry
        rpUser.location = user.location
        rpUser.school = user.school
        rpUser.degree = user.degree
        rpUser.forHire = user.forHire
        rpUser.token = user.token
        rpUser.about = user.about
        
        // convert work experiences
        for we in user.workExperiences{
            rpUser.workExperiences.append(RPWorkExperience.fromNTWWorkExperience(we: we))
            
        }

        // convert educations
        for ed in user.educations{
            rpUser.educations.append(RPEducation.fromNTWEducation(education: ed))
        }
        // convert interests
        for interest in user.interests{
            rpUser.interests.append(RPInterest.fromNTWInterest(interest: interest))
        }
        
        // convert skills
        for skill in user.skills{
            rpUser.skills.append(RPSkill.fromNTWSkill(skill: skill))
        }
        return rpUser
        
        
        
    }
}
