//
//  NTWPasswordRecoveryConfirmationViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/3/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

protocol NTWPasswordRecoveryConfirmationViewDelegate: class
{
    func goToSignInView()
}


class NTWPasswordRecoveryConfirmationViewController: UIViewController {

    
    // MARK: - Properties
    
    weak var delegate: NTWPasswordRecoveryConfirmationViewDelegate?
    
    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    
    @IBAction func emailSentButtonAction(_ sender: Any) {
        self.delegate?.goToSignInView()
        self.dismiss(animated: true, completion: nil)
    }
    
}
