//
//  CloudStorageTest.swift
//  Networkd
//
//  Created by Carlos Rios on 5/5/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import XCTest
@testable import Networkd
class CloudStorageTest: NetworkdTestSuite {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testThatCanAuthenticateUser()
    {
//         given
        let username = "cariosvertel@gmail.com"
        let password = "carlos"
        let fakeNetwork = NetworkFake()
        fakeNetwork.responseType = ResponseType.Login(true)
        fakeNetwork.response = self.getResponse(type: .Login(true))
        let cloud = Cloud(adapter: fakeNetwork)
        var responseUser:RPUser? = nil
        // when
        cloud.authenticateUser(username, password:  password){
            user, error in
            responseUser = user
        }
        // then
        validateUser(user: responseUser)
    }
    func testThatHandleErrorOnLogin()
    {
        // given
        let username = "cariosvertel@gmail.com"
        let password = "carlos"
        let fakeNetwork = NetworkFake()
        fakeNetwork.responseType = ResponseType.Login(false)
        fakeNetwork.error = self.getResponse(type: .Login(false))
        let cloud = Cloud(adapter: fakeNetwork)
        var responseError:RPError? = nil
        // when
        cloud.authenticateUser(username, password:  password){
            user, error in
            responseError = error
        }
        // then
        XCTAssertNotNil((responseError))
        XCTAssertEqual(responseError?.localizedDescription, "Invalid email or password.")
    }
    func testThatConvertEmailToMD5()
    {
        // give
        let email = "MyEmailAddress@example.com"
        
        // when
        let md5 = Cloud.covertToMD5(email:email)
        
        // when
        XCTAssertEqual(md5, "0bc83cb571cd1c50ba6f3e8a78ef1346")
    }
    
    /* 
        Helpers methods
     */
 
    func validateUser(user:RPUser?)
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
    func validateUserInfo(user: RPUser?)
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
    func validateWorkExperience(experience:RPWorkExperience?)
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
    func validateEducation(_ education: RPEducation?)
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
    func validateInterest(_ interest: RPInterest?)
    {
        XCTAssertEqual(interest?.id, "50")
        XCTAssertEqual(interest?.title, "Development")
    }
    func validateSkill(_ skill: RPSkill?)
    {
        XCTAssertEqual(skill?.id, "50")
        XCTAssertEqual(skill?.title, "Development")
    }
    
    
    
}
