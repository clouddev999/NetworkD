//
//  LocalFake.swift
//  Networkd
//
//  Created by Cloud Stream on 5/9/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation

@testable import Networkd
@testable import RealmSwift

class LocalFake: LocalStorage {

    var defaultUser: RPUser?
    var fetchEmail: String?
    func saveOrUpdate<T:Object>(object: T) {
    }
    func getSession() -> RPSession{
        let session = RPSession()
        session.defaultUserEmail = "cariosvertel@gmail.com"
        return session
    }
    func fetchUser(email: String) -> RPUser?
    {
        if self.fetchEmail == email{
            return defaultUser
        }
        return nil
    }
}
