//
//  UserRepo.swift
//  Networkd
//
//  Created by Carlos Rios on 5/9/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation


typealias CompletionBlock<T> = ( _ resultObj: T? , _ error : ITError?) -> Void

protocol UserRepo {
    func signIn(_ email: String, password: String, callback: @escaping CompletionBlock<NTWUser>)
    func getSession() -> NTWSession?
    func fetchUser(email: String) -> NTWUser?
    func signup(_ email:String, _ password: String, callback:@escaping CompletionBlock<NTWUser>)
    func signup(_ email:String, _ password: String,_ gravatar:NTWGravatar?, callback:@escaping CompletionBlock<NTWUser>)
    func fetchAvatar(_ email: String, callback:@escaping CompletionBlock<NTWGravatar>)
    func resetPassword(_ email: String, callback: @escaping CompletionBlock<NTWSuccess>)
}

class Repo: UserRepo{
    
    var local: LocalStorage
    var cloud: CloudStorage
    
    
    init(local: LocalStorage, cloud: CloudStorage) {
        self.local = local
        self.cloud = cloud
    }
    /*
     
        CLOUD STORAGE METHODS
     */
    func signIn(_ email: String, password: String, callback: @escaping (NTWUser?, ITError?) -> Void) {
        
        self.createOrAuthenticate(email, password,gravatar: nil, create: false, callback: callback)
    }
    func signup(_ email: String, _ password: String, callback: @escaping (NTWUser?, ITError?) -> Void) {
        
        self.createOrAuthenticate(email, password, gravatar: nil, create: true, callback: callback)
    }
    func signup(_ email: String, _ password: String, _ gravatar: NTWGravatar?, callback: @escaping (NTWUser?, ITError?) -> Void) {
        
        self.createOrAuthenticate(email, password, gravatar: gravatar, create: true, callback: callback)
    }
    func createOrAuthenticate(_ email: String, _ password: String,gravatar:NTWGravatar?, create:Bool, callback: @escaping (NTWUser?, ITError?) -> Void)
    {
        // block to handle response
        let callbackBlock = {  (user: RPUser?, error: RPError?) -> Void in
            if let validError = error{
                let itError = ITError.Error(cause: validError.localizedDescription)
                callback(nil, itError)
            }else if let validUser = user{
                // save what's session user email
                let session = self.local.getSession()
                self.local.saveOrUpdate(object: validUser)
                session.defaultUserEmail = validUser.email
                self.local.saveOrUpdate(object: session)
                
                callback(validUser.toNTWUser(), nil)
            }
        }
        if create {
            self.cloud.signup(email, password: password,gravatar:gravatar, callback: callbackBlock)
        }else{
            self.cloud.authenticateUser(email, password: password, callback: callbackBlock)
        }
    }
    func fetchAvatar(_ email: String, callback: @escaping (NTWGravatar?, ITError?) -> Void) {
        
        self.cloud.fetchAvatar(email){
            avatar , error in
            if let validError = error{
                let itError = ITError.Error(cause: validError.localizedDescription)
                callback(nil, itError)
            }else if let validAvatar = avatar {
                callback(validAvatar.toNTWGravatar(), nil)
            }
        }
    }
    func resetPassword(_ email: String, callback: @escaping (NTWSuccess?, ITError?) -> Void) {
        self.cloud.resetPassword(email){
            success, error in
            if let validError = error{
                let itError = ITError.Error(cause: validError.localizedDescription)
                callback(nil, itError)
            }else if let validSuccess = success {
                callback(validSuccess.toNTWSuccess(), nil)
            }
        }
    }
    /* 
     
        LOCAL STORAGE METHODS
     */
    func fetchUser(email: String) -> NTWUser?
    {
        return self.local.fetchUser(email: email)?.toNTWUser()
    }
    func getSession() -> NTWSession? {
        return self.local.getSession().toNTWSession()
    }
    
}
