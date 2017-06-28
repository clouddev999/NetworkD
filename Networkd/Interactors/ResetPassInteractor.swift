//
//  ResetPassInteractor.swift
//  Networkd
//
//  Created by Cloud Stream on 5/10/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import Foundation

class ResetPassInteractor: BaseInteractor {
    
    func resetPasswordRequest(_ email: String)
    {
        self.repo.resetPassword(email){
            [unowned weakSelf = self] success, error in
            weakSelf.output.onResponse(response: success, error: error)
        }
    }
}
