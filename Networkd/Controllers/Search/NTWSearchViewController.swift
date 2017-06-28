//
//  NTWCompanyPickerViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/8/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftMessages

enum NTWSearchType: Int
{
    case companies = 0, institutions, interests, skills, location
}

class NTWSearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var companiesTableView: UITableView!
    
    var searchType: NTWSearchType!
    var numberOfResultsForTest = 0
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.keyboardType = .default
        self.searchTextField.autocorrectionType = .no
        self.searchTextField.autocapitalizationType = .none
        self.searchTextField.titleFormatter = { $0 }
        self.searchTextField.placeholderFont = UIFont.systemFont(ofSize: 14)
        self.searchTextField.font = UIFont.systemFont(ofSize: 15)
        self.searchTextField.becomeFirstResponder()
        
        if self.searchType == .companies {
            self.searchTextField.placeholder = "Company Name"
        }
        
        if self.searchType == .institutions {
            self.searchTextField.placeholder = "Institution Name"
        }
        
        if self.searchType == .interests {
            self.searchTextField.placeholder = "Name of Interests"
        }
        
        if self.searchType == .skills {
            self.searchTextField.placeholder = "Name of Skills"
        }
        
        if self.searchType == .location {
            self.searchTextField.placeholder = "Name of City"
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchTextFieldEditingChaged(_ sender: Any) {
        if self.searchType == .companies {
            if "apple".contains(self.searchTextField.text!.lowercased()) {
                self.numberOfResultsForTest = 1
            } else {
                self.numberOfResultsForTest = 0
            }
        }
        
        if self.searchType == .institutions {
            if "universidad del norte".contains(self.searchTextField.text!.lowercased()) {
                self.numberOfResultsForTest = 1
            } else {
                self.numberOfResultsForTest = 0
            }
        }
        
        if self.searchType == .interests {
            if "friendship".contains(self.searchTextField.text!.lowercased()) {
                self.numberOfResultsForTest = 1
            } else {
                self.numberOfResultsForTest = 0
            }
        }
        
        if self.searchType == .skills {
            if "ios".contains(self.searchTextField.text!.lowercased()) {
                self.numberOfResultsForTest = 1
            } else {
                self.numberOfResultsForTest = 0
            }
        }
        
        if self.searchType == .location {
            if "barranquilla".contains(self.searchTextField.text!.lowercased()) {
                self.numberOfResultsForTest = 1
            } else {
                self.numberOfResultsForTest = 0
            }
        }
        
        self.companiesTableView.reloadData()

    }

    @IBAction func addButtonAction(_ sender: Any) {
        self.counter += 1
        if searchType == .interests {
            if self.counter >= 7 {
                self.showSnackBar(withMessage: "Sorry you have already selected 7 interests. Please unselect an interest and try again.")
            }
        } else if searchType == .skills {
            
        } else {
            self.view.endEditing(true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
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


extension NTWSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfResultsForTest
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        if self.searchType == .companies {
            cell.textLabel?.text = "Apple"
            cell.imageView?.image = UIImage(named: "appleLogo.jpg")
        }
        
        if self.searchType == .institutions {
            cell.textLabel?.text = "Uninorte"
            cell.imageView?.image = UIImage(named: "uninorte.png")
        }
        
        if self.searchType == .interests {
            cell.textLabel?.text = "Friendship"
        }

        if self.searchType == .skills {
            cell.textLabel?.text = "iOS"
        }
        
        if self.searchType == .location {
            cell.textLabel?.text = "Barranquilla - Atlántico, Colombia"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchType == .companies || searchType == .institutions || searchType == .location {
            self.view.endEditing(true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

}
