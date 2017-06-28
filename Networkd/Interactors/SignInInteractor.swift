//
//  SignInInteractor.swift
//  Networkd
//
//  Created by Cloud Stream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

class SignInInteractor: BaseInteractor {
    
    func signIn(_ email: String, password: String)
    {
        self.repo.signIn(email, password: password) {
            [unowned weakSelf = self] user, error in
            weakSelf.output.onResponse(response: user,error: error)
        }
    }
    func fetchSessionUser() -> NTWUser?
    {
        if let session = self.repo.getSession(),
            let defaultUserEmail = session.defaultUserEmail,
            let defaultUser = self.repo.fetchUser(email:defaultUserEmail) {
            return defaultUser
        }
        return nil
    }
    func signup(_ username: String, _ password: String)
    {
        // first we check if email has gravatar image
        self.repo.fetchAvatar(username){
            [unowned weakSelf = self] avatar, error in
            
            // with gravatar image. we make signup
            weakSelf.repo.signup(username, password, avatar){
                user, error in
                weakSelf.output.onResponse(response: user, error: error)
            }
        }
    }
}
