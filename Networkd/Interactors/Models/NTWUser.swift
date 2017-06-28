//
//  NTWUser.swift
//  Networkd
//
//  Created by CloudStream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import UIKit

class NTWUser {
    var email: String?
    var firstName: String?
    var lastName: String?
    var profilePicture: UIImage?
    var id: String? = nil
    var position: String?
    var company: String?
    var industry: String?
    var location: String?
    var school: String?
    var degree: String?
    var forHire = true
    var token: String?
    var about: String?
    var avatar: String?
    var workExperiences = [NTWWorkExperience]()
    var educations = [NTWEducation]()
    var interests = [NTWInterest]()
    var skills = [NTWSkill]()
}
