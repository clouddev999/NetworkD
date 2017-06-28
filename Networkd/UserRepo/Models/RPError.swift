//
//  RPError.swift
//  Networkd
//
//  Created by Cloud Stream on 5/7/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
enum RPError: Error {
    case Error(cause:String)
    var localizedDescription: String{
        switch self {
        case .Error(let cause):
            return cause;
        }
    }
    static func getFirstError(_ response:[String: AnyObject]?) ->RPError?
    {
        if let validResponse = response, let errors = validResponse["errors"] as? Array<[String: AnyObject]>{
            
            let firstError = errors.first
            return RPError.fromJson(firstError)
        }
        return nil
    }
    static func fromJson(_ json:[String: AnyObject]?) -> RPError?
    {
        if let description = json?["message"] as? String{
            return RPError.Error(cause: description)
        }
        return nil
    }
}
