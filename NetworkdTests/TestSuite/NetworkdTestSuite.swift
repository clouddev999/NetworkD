//
//  NetworkdTestSuite.swift
//  Networkd
//
//  Created by Cloud Stream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import XCTest
@testable import Networkd
class NetworkdTestSuite: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func loadPlistFile(filename: String)->[String: AnyObject]
    {
        let path = Bundle(for: self.classForCoder).path(forResource: filename, ofType: "plist")
        return NSDictionary(contentsOfFile: path!) as! [String: AnyObject]
    }
    func getResponse(type: ResponseType) -> [String: AnyObject]
    {
        switch type {
        case .Login(let success):
            if success{
                return loadPlistFile(filename: "login")
            }else{
                return loadPlistFile(filename: "login_wrong")
            }
        case .SignUp(let success):
            if success {
                return loadPlistFile(filename: "signup")
            }else{
                return loadPlistFile(filename: "signup")
            }
        case .Gravatar:
            return loadPlistFile(filename: "gravatar")
        case .ResetPass(let success):
            if success {
                return loadPlistFile(filename: "success")
            }else{
                return loadPlistFile(filename: "error_reset_pass")
            }
        default:
            break
        }

    }
    func getSampleUser() -> RPUser?
    {
        let data = loadPlistFile(filename: "login")
        return RPUser.fromJson(data)
    }
    
    /*
     Helpers methods
     */
    
    func validateUser(user:NTWUser?)
    {
        // validate personal info
        validateUserInfo(user: user)
        // extract work Experience
        XCTAssertEqual(user?.workExperiences.count,2)
        let experience = user?.workExperiences.first
        validateWorkExperience(experience: experience)
        
        // validate education
        XCTAssertEqual(user?.educations.count,1)
        let education = user?.educations.first
        validateEducation(education)
        
        // validate interests
        XCTAssertEqual(user?.interests.count,7)
        let interest = user?.interests.first
        validateInterest(interest)
        
        // validate skills
        XCTAssertEqual(user?.skills.count,2)
        let skill = user?.skills.first
        validateSkill(skill)
    }
    func validateUserInfo(user: NTWUser?)
    {
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, "1")
        XCTAssertEqual(user?.firstName, "Carlos")
        XCTAssertEqual(user?.lastName, "Rios")
        XCTAssertEqual(user?.position, "Team Lead")
        XCTAssertEqual(user?.company, "Refundo")
        XCTAssertEqual(user?.industry, "IT")
        XCTAssertEqual(user?.location, "Barranquilla, BQ, Colombia")
        XCTAssertEqual(user?.school, "Univeridad Del Norte")
        XCTAssertEqual(user?.degree, "Electronic Engineer")
        XCTAssertEqual(user?.forHire, false)
        XCTAssertEqual(user?.token, "ab97225b2d4e0ba27a130c8887a0979e9bb9da5b")
        XCTAssertEqual(user?.about, "Soy carlos")
        XCTAssertEqual(user?.email, "carlos@refundo.com")
        XCTAssertEqual(user?.avatar, "")
    }
    func validateWorkExperience(experience:NTWWorkExperience?)
    {
        XCTAssertEqual(experience?.title, "Asistente Tecnico")
        XCTAssertEqual(experience?.location, "Bogota")
        XCTAssertEqual(experience?.expDescription, "Asistente tecnico")
        XCTAssertEqual(experience?.company, "Iglesia Manantial de Vida en Rahway, New Jersey")
        XCTAssertEqual(experience?.currentlyHere, false)
        XCTAssertEqual(experience?.id, "37")
        XCTAssertEqual(experience?.companyLogo, "https://logo.clearbit.com/manantialcc.org")
        XCTAssertTrue(experience?.dateFrom?.timeIntervalSince1970 == 1320123600)
        XCTAssertTrue(experience?.dateTo?.timeIntervalSince1970 == 1488344400)
    }
    func validateEducation(_ education: NTWEducation?)
    {
        XCTAssertEqual(education?.edDescription, "Bachiller")
        XCTAssertEqual(education?.degree, "Bachiller Academico")
        XCTAssertEqual(education?.institution, "ColegioSanFrancisco")
        XCTAssertEqual(education?.averageScore, "4.8")
        XCTAssertEqual(education?.universityLogo, "https://logo.clearbit.com/colegiosanfrancisco.edu.ec")
        XCTAssertEqual(education?.id, "176")
        XCTAssertTrue(education?.dateFrom?.timeIntervalSince1970 == 1041397200)
        XCTAssertTrue(education?.dateTo?.timeIntervalSince1970 == 1130821200)
    }
    func validateInterest(_ interest: NTWInterest?)
    {
        XCTAssertEqual(interest?.id, "50")
        XCTAssertEqual(interest?.title, "Development")
    }
    func validateSkill(_ skill: NTWSkill?)
    {
        XCTAssertEqual(skill?.id, "50")
        XCTAssertEqual(skill?.title, "Development")
    }
    
    
  
}
