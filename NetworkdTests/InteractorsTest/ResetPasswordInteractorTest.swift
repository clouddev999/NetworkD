//
//  ResetPasswordInteractorTest.swift
//  Networkd
//
//  Created by Cloud Stream on 5/10/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import XCTest
@testable import Networkd
class ResetPasswordInteractorTest: BaseInteractorTest {
    var interactor: ResetPassInteractor?
    var view: BaseViewFake<NTWSuccess>?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.view = BaseViewFake<NTWSuccess>()
        self.presenter = BasePresenter(view:self.view!)
        self.interactor = ResetPassInteractor(output:self.presenter!, repo: self.repo!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testThatCanResetPassword()
    {
        // given
        let email = "carlosvertel@gmail.com"
        self.adapter?.responseGet = getResponse(type: .ResetPass(true))
        self.adapter?.responseTypeGet = ResponseType.ResetPass(true)
        // when
        self.interactor?.resetPasswordRequest(email)
        // then
        XCTAssertEqual(self.adapter?.parameters?["email"],email)
        XCTAssertEqual(self.view?.resultObject?.message, "OK")
    }
    func testThatHandleEmailNotFound()
    {
        // given
        let email = "carlosvertel@gmail.com"
        self.adapter?.error = getResponse(type: .ResetPass(false))
        self.adapter?.responseTypeGet = ResponseType.ResetPass(false)
        // when
        self.interactor?.resetPasswordRequest(email)
        // then
        XCTAssertEqual(self.view?.error?.localizedDescription, "User does not exists")
    }
}
