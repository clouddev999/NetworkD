//
//  NTWCreateAPostViewController.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/9/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit
import AnimatedTextInput
import SwiftMessages

class NTWCreateAPostViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var subjectTextField: AnimatedTextInput!
    @IBOutlet weak var messageTextfField: AnimatedTextInput!
    
    
    // MARK: - UIViewController Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTextFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBOutlets Actions
    
    @IBAction func postButtonAction(_ sender: Any) {
        if self.inputsAreValid {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - UITextField Validations
    
    private var inputsAreValid: Bool {
        var inputsAreValid = true
        
        if self.areThereEmptyFields {
            inputsAreValid = false
            self.showSnackBar(withMessage:  "There are empty fields")
            return inputsAreValid
        }
        return inputsAreValid
    }
    
    private var areThereEmptyFields: Bool {
        let inputs = [self.subjectTextField, self.messageTextfField]
        var isEmpty = false
        
        for input in inputs {
            if input?.text?.trimmingCharacters(in: .whitespaces) == "" {
                isEmpty = true
                return isEmpty
            }
        }
        return isEmpty
    }
    
    // MARK: - Helper Methods
    
    private func configureTextFields() {
        self.subjectTextField.style = NTWTextInputStyle()
        self.subjectTextField.placeHolderText = "Subject"
        self.subjectTextField.type = .multiline
        self.subjectTextField.showCharacterCounterLabel(with: 200)
        
        self.messageTextfField.style = NTWTextInputStyle()
        self.messageTextfField.placeHolderText = "Message"
        self.messageTextfField.type = .multiline
        self.messageTextfField.showCharacterCounterLabel(with: 600)
    }
    
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

}
