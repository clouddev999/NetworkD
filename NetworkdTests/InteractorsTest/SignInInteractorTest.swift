//
//  SignInInteractorTest.swift
//  Networkd
//
//  Created by Carlos Rios on 5/9/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import XCTest

@testable import Networkd
class SignInInteractorTest: BaseInteractorTest {
    
    var interactor: SignInInteractor?
    var view: BaseViewFake<NTWUser>?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = BaseViewFake<NTWUser>()
        self.presenter = BasePresenter(view:self.view!)
        self.interactor = SignInInteractor(output:self.presenter!, repo: self.repo!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testThatCanLoginUserWithValidCredentials()
    {
        // given
        self.adapter?.response = getResponse(type: .Login(true))
        self.adapter?.responseType = ResponseType.Login(true)
        // when
        self.interactor?.signIn("cariosvertel@gmail.com", password: "carlos")
        // then
        validateUser(user: self.view?.resultObject)
    }
    func testThatHandleLoginResponseWithWrongCredentials()
    {
        // given
        self.adapter?.error = getResponse(type: .Login(false))
        self.adapter?.responseType = ResponseType.Login(false)
        // when
        self.interactor?.signIn("cariosvertel@gmail.com", password: "carlos")
        // then
        XCTAssertNotNil(self.view?.error)
        XCTAssertEqual(self.view?.error?.localizedDescription, "Invalid email or password.")
    }
    func testThatFecthDefaultUserFromLocalStorage()
    {
        // given
        self.local?.fetchEmail = "cariosvertel@gmail.com"
        self.local?.defaultUser = getSampleUser()
        // when
        let user = interactor?.fetchSessionUser()
        // then
        validateUser(user: user)
    }
    
    func testThatSignUpANewUser()
    {
        // given
        let username = "riosc@gmail.com"
        let password = "password"
        self.adapter?.responseTypeGet = ResponseType.Gravatar(false)
        self.adapter?.responseGet = getResponse(type:.Gravatar(false))
        
        self.adapter?.responseType = ResponseType.SignUp(true)
        self.adapter?.response = getResponse(type:.SignUp(true))
        
        // when
        interactor?.signup(username, password)
        // then
        self.adapter?.validateUserData(withGravatar: false)
        self.view?.validateSignupUser()

    }
    func testThatSignUpANewUserWithGravatar()
    {
        // given
        let username = "riosc@gmail.com"
        let password = "password"
        self.adapter?.responseType = ResponseType.SignUp(true)
        self.adapter?.response = getResponse(type:.SignUp(true))
        self.adapter?.responseTypeGet = ResponseType.Gravatar(true)
        self.adapter?.responseGet = getResponse(type:.Gravatar(true))
        
        // when
        interactor?.signup(username, password)
        // then
        self.adapter?.validateUserData(withGravatar: true)
        self.view?.validateSignupUser()
        
    }
    
    
}
