//
//  BaseViewFake.swift
//  Networkd
//
//  Created by Carlos Rios on 5/9/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation
import XCTest
@testable import Networkd

class BaseViewFake<E>: BaseView {
    var resultObject:E?
    var error: ITError?
    func onSuccess<T>(object:T) {
        resultObject = object as? E
    }
    func onError(error: ITError) {
        self.error = error
    }
    func validateSignupUser()
    {
        if let typeUser = self.resultObject as? NTWUser{
            XCTAssertEqual(typeUser.email,"riosc@gmail.com")
            XCTAssertEqual(typeUser.id,"75")
            XCTAssertEqual(typeUser.token,"284ac6bad6693a0e0811b7535bde23fa0e4bb3c5")
            XCTAssertEqual(typeUser.firstName, "")
            XCTAssertEqual(typeUser.lastName, "")
        }
    }
    
}
