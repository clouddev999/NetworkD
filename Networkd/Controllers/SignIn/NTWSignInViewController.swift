//
//  NTWSignInViewController.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/2/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit
import SwiftMessages
import DeviceKit
import AnimatedTextInput

class NTWSignInViewController: UIViewController {
    
    // MARK: - Properties
    
    var interactor: SignInInteractor?
    
    
    // MARK: - IBOulets
    
    @IBOutlet weak var emailTextField: AnimatedTextInput!
    @IBOutlet weak var passwordTextField: AnimatedTextInput!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpBottomButton: UIButton!
    @IBOutlet weak var baseLine: UIView!
    

    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = SignInInteractor.createInstance(typeThing: SignInInteractor.self , view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.configureInputs()
        self.configureForgotButtonLayout()
        #if DEBUG
            self.emailTextField.text = "mario@refundo.com"
            self.passwordTextField.text = "1234"
        #endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - IBOutles Actions
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if self.inputsAreValid {
            ProgressInteractor.shared.showProgress(withMessage: "Please wait a moment", inWindow: self.view.window!)
            self.interactor?.signIn(self.emailTextField.text!, password: self.passwordTextField.text!)
        }
    }
    
    
    // MARK: - UITextField Validations
    
    private var inputsAreValid: Bool {
        var inputsAreValid = true
        
        if  InputsValidator.shared.areThereEmptyFields(fields: [self.emailTextField!, self.passwordTextField!]) {
            inputsAreValid = false
            MessagesInteractor.shared.showSnack(withMessage: "There are empty fields")
            return inputsAreValid
        }
        
        if !self.emailTextField.text!.isEmail {
            inputsAreValid = false
            MessagesInteractor.shared.showSnack(withMessage: "Email is not valid")
            return inputsAreValid
        }
        
        return inputsAreValid
    }
    
    
    // MARK: Helper Methods
    
    private func configureInputs() {
        self.emailTextField.style = NTWTextInputStyle()
        self.emailTextField.type = .email
        self.emailTextField.placeHolderText = "Email"
        
        self.passwordTextField.style = NTWTextInputStyle()
        self.passwordTextField.type = .password(toggleable: false)
        self.passwordTextField.placeHolderText = "Password"
    }
    
    private func configureForgotButtonLayout() {
        let device = Device()
        switch device {
        case .simulator(.iPhone4), .iPhone4, .simulator(.iPhone4s), .iPhone4s, .simulator(.iPhone5), .iPhone5,
             .simulator(.iPhone5c), .iPhone5c, .simulator(.iPhone5s), .iPhone5s, .simulator(.iPhoneSE), .iPhoneSE:
            if self.signUpButton != nil {
                self.signUpButton.removeFromSuperview()
            }
        default:
            if self.signUpBottomButton != nil {
                self.signUpBottomButton.removeFromSuperview()
            }
            if self.baseLine != nil {
                self.baseLine.removeFromSuperview()
            }
        }
    }
    
}


extension NTWSignInViewController: BaseView {
    
    func onError(error: ITError) {
        ProgressInteractor.shared.hideProgress()
        MessagesInteractor.shared.showSnack(withMessage: error.localizedDescription)
    }
    
    func onSuccess(object: AnyObject) {
        ProgressInteractor.shared.hideProgress()
        if let v = object as? NTWUser{
            print("LOGGED USER " + v.token!)
            self.performSegue(withIdentifier: "toNewsView", sender: nil)
        }
    }
}

