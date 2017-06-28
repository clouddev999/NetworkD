//
//  NetworkdAdapter.swift
//  Networkd
//
//  Created by Cloud Stream on 5/7/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation
import Alamofire
protocol NetworkdAdapter: class {
    func post(parameters: [String: String], url:String, callback:@escaping (_ response:[String:AnyObject]?, _ error:NetworkError?) -> Void)
    func get(parameters: [String: String]?, url:String, callback:@escaping (_ response:[String:AnyObject]?, _ error:NetworkError?) -> Void)
}

enum NetworkError:Error {
    case Error(cause:String)
    var localizedDescription: String{
        switch self {
        case .Error(let cause):
            return cause;
        }
    }
}
class AlamofireAdapter: NetworkdAdapter{
    
    func post(parameters: [String : String], url: String, callback: @escaping ([String : AnyObject]?, NetworkError?) -> Void)
    {
        Alamofire.request(url, method:.post, parameters:parameters).responseJSON {
            response in
            
            print(response.result.value)
            
            switch response.result {
            case .success(let value):
                callback((value as! [String: AnyObject]), nil)
            case .failure(let error):
                callback(nil, NetworkError.Error(cause: error.localizedDescription))
            }
        }
    }
    func get(parameters: [String : String]?, url: String, callback: @escaping ([String : AnyObject]?, NetworkError?) -> Void) {
        
        Alamofire.request(url, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                if let castResponse = value as? String{
                    callback(nil, NetworkError.Error(cause: castResponse))
                }else if let validProfile = value as? [String: AnyObject] {
                    callback(validProfile, nil)
                }else{
                    callback(nil, NetworkError.Error(cause: "Unknown Error"))
                }
            case .failure(let error):
                callback(nil, NetworkError.Error(cause: error.localizedDescription))
            }
        }
    }
}

