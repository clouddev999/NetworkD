//
//  BaseInteractor.swift
//  Networkd
//
//  Created by Cloud Stream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

class BaseInteractor {
  
    var repo: UserRepo
    var output: BaseInteractorOutput
    
    required init(output:BaseInteractorOutput, repo: UserRepo) {
        self.repo = repo
        self.output = output
    }
    class func createInstance<T:BaseInteractor>(typeThing:T.Type,view:BaseView) -> T {
        let adapter = AlamofireAdapter()
        let cloud = Cloud(adapter: adapter)
        let local = Local()
        let repo = Repo(local:local,cloud: cloud)
        let presenter = BasePresenter(view: view)
        return typeThing.init(output:presenter, repo:repo)
    }
}
enum ITError: Error {
    case Error(cause: String)
    
    var localizedDescription: String{
        switch self {
        case .Error(let cause):
            return cause
        default:
            break
        }
    }
}
