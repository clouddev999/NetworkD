//
//  NTWPasswordRecoveryViewController.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/3/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit
import SwiftMessages
import MBProgressHUD
import AnimatedTextInput

class NTWPasswordRecoveryViewController: UIViewController {

    
    // MARK: - IBOulets
    
    @IBOutlet weak var emailTextField: AnimatedTextInput!
    
    
    // MARK: - UIViewController Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.style = NTWTextInputStyle()
        self.emailTextField.type = .email
        self.emailTextField.placeHolderText = "Email"
        
        #if DEBUG
            self.emailTextField.text = "mario@test.com"
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - IBOutles Actions
    
    @IBAction func resetPasswordButtonAction(_ sender: Any) {
        if self.inputsAreValid {
            self.view.endEditing(true)
            self.showSpinning {
                self.performSegue(withIdentifier: "toPasswordRecoveryConfirmationView", sender: nil)
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextField Validations
    
    private var inputsAreValid: Bool {
        var inputsAreValid = true
        
        if self.areThereEmptyFields {
            inputsAreValid = false
            self.showSnackBar(withMessage:  "There are empty fields")
            return inputsAreValid
        }
        
        if !self.emailTextField.text!.isEmail {
            inputsAreValid = false
            self.showSnackBar(withMessage:  "Email is not valid")
            return inputsAreValid
        }
        
        return inputsAreValid
    }
    
    private var areThereEmptyFields: Bool {
        let inputs = [self.emailTextField]
        var isEmpty = false
        
        for input in inputs {
            if input?.text?.trimmingCharacters(in: .whitespaces) == "" {
                isEmpty = true
                return isEmpty
            }
        }
        return isEmpty
    }
    
    
    // MARK: Helper Methods
    
    private func showSnackBar(withMessage message: String) {
        let snackView: SnackBar = try! SwiftMessages.viewFromNib()
        snackView.configureContent(body: message)
        snackView.configureTheme(backgroundColor: UIColor.NTWBlue, foregroundColor: .white, iconImage: UIImage(named: "infoIcon"), iconText: nil)
        snackView.titleLabel?.isHidden = true
        snackView.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 1)
        config.shouldAutorotate = true
        config.interactiveHide = true
        
        SwiftMessages.show(config: config, view: snackView)
    }
    
    private func showSpinning(completionHandler: @escaping () -> Void) {

        let hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        hud.contentColor = UIColor.NTWBlue
        hud.label.text = "Please wait a moment"
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.textColor = .darkGray
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(hex: 0, alpha: 0.7)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 1.0, alpha: 0.9)
        hud.show(animated: true)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            completionHandler()
            hud.hide(animated: false)
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPasswordRecoveryConfirmationView" {
            let confirmationController = segue.destination as! NTWPasswordRecoveryConfirmationViewController
            confirmationController.delegate = self
        }
    }
}


extension NTWPasswordRecoveryViewController: NTWPasswordRecoveryConfirmationViewDelegate {

    func goToSignInView() {
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
}

