//
//  BasePresenter.swift
//  Networkd
//
//  Created by Cloud Stream on 5/5/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

protocol BaseInteractorOutput {
    func onResponse<T>(response: T?, error:ITError?)
}

protocol BaseView: class {
    
    func onSuccess(object:AnyObject)
    func onError(error: ITError)
    
}

class BasePresenter: BaseInteractorOutput {
    weak var view: BaseView?
    init(view: BaseView? ) {
        self.view = view
    }
    func onResponse<T>(response: T?, error: ITError?) {
        if let validResponse = response{
            self.view?.onSuccess(object: validResponse as AnyObject)
        }else if let validError = error{
            self.view?.onError(error: validError)
        }else{
            self.view?.onError(error: ITError.Error(cause: "An errror ocurred but app was unabled to detected it."))
        }
    }
}
