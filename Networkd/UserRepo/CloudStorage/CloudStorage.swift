//
//  CloudStorage.swift
//  Networkd
//
//  Created by Cloud Stream on 5/7/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import CryptoSwift


typealias CloudBlock<T> = ( _ resultObj: T? , _ error : RPError?) -> Void
protocol CloudStorage {
    func authenticateUser(_ username: String, password: String, callback: @escaping CloudBlock<RPUser>)
    func signup(_ username: String, password: String, callback: @escaping CloudBlock<RPUser>)
    func signup(_ username: String, password: String, gravatar:NTWGravatar?, callback: @escaping CloudBlock<RPUser>)
    func fetchAvatar(_ email:String, callback: @escaping CloudBlock<RPGravatar>)
    func resetPassword(_ email: String, callback: @escaping CloudBlock<RPSuccess>)
}
class Cloud: CloudStorage{
    
    var adapter: NetworkdAdapter
    
    init(adapter: NetworkdAdapter) {
        self.adapter = adapter
    }
    func authenticateUser(_ username: String, password: String, callback: @escaping (RPUser?, RPError?) -> Void) {
        
        self.createOrAthenticate(username, password: password,gravatar: nil, create: false, callback: callback)
    }
    func signup(_ username: String, password: String, callback: @escaping (RPUser?, RPError?) -> Void) {
        self.createOrAthenticate(username, password: password,gravatar: nil, create: true, callback: callback)
    }
    func signup(_ username: String, password: String, gravatar: NTWGravatar?, callback: @escaping (RPUser?, RPError?) -> Void) {
        
        self.createOrAthenticate(username, password: password,gravatar: gravatar?.gravatarUrl, create: true, callback: callback)
    }
    func createOrAthenticate(_ username: String, password: String,gravatar:String?, create: Bool, callback: @escaping (RPUser?, RPError?) -> Void)
    {
        let endPoint = create ? RPConstants.kBaseURL + "api/v1/users/create/" : RPConstants.kBaseURL + "api/v1/users/login/"
        var params = ["email": username, "password": password]
        if let validGravatar = gravatar{
            params["gravatar_url"] = validGravatar
        }
        self.adapter.post(parameters: params, url: endPoint) {
            response, error in
            if let success = response?["success"] as? Bool, success == true{
                if let validUser = RPUser.fromJson(response){
                    callback(validUser, nil)
                }else {
                    callback(nil, RPError.Error(cause: "User object does not has valid data"))
                }
            }else if let firstError = RPError.getFirstError(response){
                callback(nil, firstError)
                
            }else if let validError = error{
                callback(nil, RPError.Error(cause: validError.localizedDescription))
            }
        }
    }
    func fetchAvatar(_ email: String, callback: @escaping (RPGravatar?, RPError?) -> Void) {
        
        let hashEmail = Cloud.covertToMD5(email: email)
        let endPoint = RPConstants.kGravatarBaseURL + hashEmail + ".json"
        self.adapter.get(parameters: nil, url: endPoint) {
            response, error in
            if let validResponse = response, let gravatar = RPGravatar.fromJson(json: validResponse){
                callback(gravatar, nil)
            }else if let validError = error{
                callback(nil, RPError.Error(cause: validError.localizedDescription))
            }
        }
    }
    func resetPassword(_ email: String, callback: @escaping (RPSuccess?, RPError?) -> Void) {
        let endPoint = RPConstants.kBaseURL + "api/v1/users/reset/"
        let params = ["email": email]
        self.adapter.get(parameters: params, url: endPoint) {
            response, error in
            
            if let validSuccess = RPSuccess.fromJson(json:response){
              callback(validSuccess, nil)
            }else if let firstError = RPError.getFirstError(response){
                callback(nil, firstError)
                
            }else if let validError = error{
                callback(nil, RPError.Error(cause: validError.localizedDescription))
            }
        }
        
    }
    /* Helpers methods */
    
    class func covertToMD5(email: String) -> String
    {
        let hash = email.lowercased().md5()
        return hash
        
    }
 
}
