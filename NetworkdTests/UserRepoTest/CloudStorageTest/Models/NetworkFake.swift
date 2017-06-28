//
//  NetworkFake.swift
//  Networkd
//
//  Created by Cloud Stream on 5/7/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

@testable import Networkd
import XCTest
class NetworkFake: NetworkdAdapter {
    
    
    var responseType: ResponseType?
    var responseTypeGet: ResponseType?
    var response: [String: AnyObject]?
    var responseGet: [String: AnyObject]?
    var error: [String: AnyObject]?
    var parameters:[String: String]?
    func post(parameters: [String : String], url: String, callback: @escaping ([String : AnyObject]?, NetworkError?) -> Void) {
        
        switch self.responseType! {
        case .Login(let success):
            // validate url
            if url != "https://networkd.herokuapp.com/api/v1/users/login/"{
            callback(nil, NetworkError.Error(cause: ""))
            }
            // validate user and password key
            if parameters["email"] == nil, parameters["password"] == nil{
                callback(nil, NetworkError.Error(cause: ""))
            }
            if success {
                callback(self.response, nil)
            }else{
                callback(self.error, nil)
            }
        case .SignUp(let success):
            if success {
                self.parameters = parameters
                callback(self.response, nil)
            }else{
                callback(self.error, nil)
            }
        // do nothing, this request never is executed with pos
        case .Gravatar(_):
            break
            
        default:
            callback(nil, nil)
        }
    }
    func get(parameters: [String : String]?, url: String, callback: @escaping ([String : AnyObject]?, NetworkError?) -> Void)
    {
        self.parameters = parameters
        switch self.responseTypeGet! {
        case .Gravatar(let success):
            if success{
                callback(self.responseGet, nil)
            }else{
                callback(nil, NetworkError.Error(cause: "Not found."))
            }
        case .ResetPass(let success):
            if success{
                callback(self.responseGet, nil)
            }else{
                callback(self.error, nil)
            }
        default:
            break
        }
    }
    func validateUserData(withGravatar: Bool)
    {
        if withGravatar{
            XCTAssertEqual(self.parameters?["gravatar_url"], "https://secure.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50")
        }
        XCTAssertEqual(self.parameters?["email"], "riosc@gmail.com")
        XCTAssertEqual(self.parameters?["password"], "password")
    }
}
enum ResponseType {
    case Login(Bool)
    case SignUp(Bool)
    case Gravatar(Bool)
    case ResetPass(Bool)
}

