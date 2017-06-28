//
//  RPSession.swift
//  Networkd
//
//  Created by Carlos Rios on 5/9/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import Foundation
import RealmSwift

class RPSession: Object {
    dynamic var defaultUserEmail: String? = nil
    
    func toNTWSession() -> NTWSession
    {
        let newSession = NTWSession()
        newSession.defaultUserEmail = self.defaultUserEmail
        return newSession
    }
    class func fromNTWSession(session:NTWSession) -> RPSession
    {
        let newSession = RPSession()
        newSession.defaultUserEmail = session.defaultUserEmail
        return newSession
    }
    override static func primaryKey() -> String? {
        return "defaultUserEmail"
    }
}
