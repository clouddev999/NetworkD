//
//  NTWSignUpViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/3/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import SwiftMessages
import DeviceKit
import AnimatedTextInput
import MBProgressHUD

class NTWSignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    var interactor: SignInInteractor?
    var hud: MBProgressHUD!
    
    
    // MARK: - IBOulets
    
    @IBOutlet weak var emailTextField: AnimatedTextInput!
    @IBOutlet weak var passwordTextField: AnimatedTextInput!
    @IBOutlet weak var repeatPasswordTextField: AnimatedTextInput!
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
            self.repeatPasswordTextField.text = "1234"
        #endif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - IBOutles Actions
    
    @IBAction func createAccountButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        if self.inputsAreValid {
            ProgressInteractor.shared.showProgress(withMessage: "Please wait a moment", inWindow: self.view.window!)
            self.interactor?.signup(self.emailTextField.text!, self.passwordTextField.text!)
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - UITextField Validations
    
    private var inputsAreValid: Bool {
        var inputsAreValid = true
        
        if  InputsValidator.shared.areThereEmptyFields(fields: [self.emailTextField!, self.passwordTextField!, self.repeatPasswordTextField!]) {
            inputsAreValid = false
            MessagesInteractor.shared.showSnack(withMessage: "There are empty fields")
            return inputsAreValid
        }
        
        if !self.emailTextField.text!.isEmail {
            inputsAreValid = false
            MessagesInteractor.shared.showSnack(withMessage: "Email is not valid")
            return inputsAreValid
        }
        
        if self.passwordTextField.text != self.repeatPasswordTextField.text {
            inputsAreValid = false
            MessagesInteractor.shared.showSnack(withMessage: "Passwords do not match")
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
        
        self.repeatPasswordTextField.style = NTWTextInputStyle()
        self.repeatPasswordTextField.type = .password(toggleable: false)
        self.repeatPasswordTextField.placeHolderText = "Repeat Password"
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


extension NTWSignUpViewController: BaseView {
    
    func onError(error: ITError) {
        ProgressInteractor.shared.hideProgress()
        MessagesInteractor.shared.showSnack(withMessage: error.localizedDescription)
    }
    
    func onSuccess<NTWUser>(object: NTWUser) {
        ProgressInteractor.shared.hideProgress()
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "newsViewController")
        self.navigationController?.setViewControllers([controller], animated: true)
    }
}



