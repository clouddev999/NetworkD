//
//  File.swift
//  Networkd
//
//  Created by Cloud Stream on 5/9/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//


import RealmSwift

protocol LocalStorage {
    func saveOrUpdate<T:Object>(object: T)
    func getSession() -> RPSession
    func fetchUser(email: String) -> RPUser?
}
class Local: LocalStorage{
    
    var realm: Realm?
    init() {
        do{
            self.realm = try Realm()
        }catch let error {
            print("ERROR: " + error.localizedDescription)
        }
    }
    func saveOrUpdate<T:Object>(object: T)
    {
        do{
            try self.realm?.write {
                if T.primaryKey() != nil{
                    realm?.add(object, update:true)
                }else{
                    realm?.add(object)
                }
            }
        }catch let error{
            print("ERROR: " + error.localizedDescription)
        }   
    }
    func getSession() -> RPSession
    {
        do{
            let session = self.realm?.objects(RPSession.self).first
            if let valid = session{
                return valid
            }
            return RPSession()
        }catch let error{
            print("ERROR: " + error.localizedDescription)
            return RPSession()
        }
    }
    func fetchUser(email: String) -> RPUser?
    {
        do{
            let predicate = NSPredicate(format: "email = %@", email)
            let result = self.realm?.objects(RPUser.self).filter(predicate)
            return result?.first
        }catch let error{
            print("ERROR: " + error.localizedDescription)
            return nil
        }
    }
}
