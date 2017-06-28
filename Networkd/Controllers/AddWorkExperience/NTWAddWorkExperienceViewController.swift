//
//  NTWAddWorkExperienceViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/8/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SwiftDate

class NTWAddWorkExperienceViewController: UIViewController {
    
    
    // MARK: - IBOutlets

    @IBOutlet weak var addExperienceTableView: UITableView!
    
    
    // MARK: - Properties
    
    var isMyCurrentWork = false
    var dateFrom = Date()
    var dateTo = Date()

    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addExperienceTableView.rowHeight = UITableViewAutomaticDimension
        self.addExperienceTableView.estimatedRowHeight = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - IBOutlets Action
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchView" {
            let navigationController = segue.destination as! UINavigationController
            let searchViewController = navigationController.topViewController as! NTWSearchViewController
            let indexPath = self.addExperienceTableView.indexPath(for: sender as! UITableViewCell)
            
            if indexPath?.row == 2 {
                searchViewController.searchType = .companies
            } else {
                searchViewController.searchType = .location
            }
        }
    }    
}


extension NTWAddWorkExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isMyCurrentWork ? 8 : 9
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
            cell.titleLabel.text = "Add Experience"
            cell.subtitleLabel.text = "Please provide more details about this position"
            cell.addButton.isHidden = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
            cell.inputTextField.placeHolderText = "Title"
            cell.inputTextField.type = .standard
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
            cell.inputTextField.placeHolderText = "Company"
            cell.inputTextField.type = .standard
            cell.rightImageView.image = UIImage(named: "ic_company")
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
            cell.inputTextField.placeHolderText = "Location"
            cell.inputTextField.type = .standard
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
            cell.inputTextField.placeHolderText = "Date From"
            cell.inputTextField.type = .standard
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! NTWSwitchTableViewCell
            cell.titleLabel.text = "I currently work here"
            cell.delegate = self
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
            cell.inputTextField.placeHolderText = "Date"
            cell.inputTextField.type = .standard
            cell.delegate = self
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
            cell.inputTextField.placeHolderText = "Description"
            cell.inputTextField.type = .standard
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! NTWButtonTableViewCell
            cell.delegate = self
            cell.button.backgroundColor = .NTWRed
            cell.button.setTitle("Remove", for: .normal)
            cell.button.setTitleColor(.white, for: .normal)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension NTWAddWorkExperienceViewController: NTWButtonCellDelegate {
    
    func didTapButton(atCell cell: UITableViewCell) {
        print("TEST")
    }
}


extension NTWAddWorkExperienceViewController: NTWInputCellDelegate {
    
    func input(atCell cell: UITableViewCell, didChangeWithText text: String) {
        if let indexPath = self.addExperienceTableView.indexPath(for: cell) {
            switch indexPath.row {
            case 5:
                break
            case 6:
                break
            default:
                break
            }
        }
    }
    
    func inputShouldBeginEditing(atCell cell: UITableViewCell) -> Bool {
        let indexPath = self.addExperienceTableView.indexPath(for: cell)!
        switch indexPath.row {
        case 2:
            self.performSegue(withIdentifier: "toSearchView", sender: cell)
            return false
        case 3:
            self.performSegue(withIdentifier: "toSearchView", sender: cell)
            return false
        case 4:
            self.presentDatePickerOnCell(cell: cell, withTitle: "Date From")
            return false
        case 6:
            self.presentDatePickerOnCell(cell: cell, withTitle: "Date To")
            return false
        default:
            return true
        }
    }

    
    private func presentDatePickerOnCell(cell: UITableViewCell, withTitle title: String) {
        self.view.endEditing(true)
        
        let indexPath = self.addExperienceTableView.indexPath(for: cell)
        var years: [String]
        var initialMonth = 0
        var initialYear = 0
        
        if indexPath?.row == 4 {
            years = self.years(from: 1900)
            initialMonth = self.dateFrom.month - 1
            initialYear = years.index(of: String(dateFrom.year))!
        } else {
            years = self.years(from: self.dateFrom.year)
            initialMonth = self.dateTo.month - 1
            initialYear = years.index(of: String(dateTo.year))!
        }
        
        let datePicker = ActionSheetMultipleStringPicker(title: title, rows: [self.months, years], initialSelection: [initialMonth, initialYear], doneBlock: { (picker, values, indexes) in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-yyyy"
            
            if indexPath?.row == 4 {
                self.dateFrom = dateFormatter.date(from: String(format: "%@-%@", (indexes as! [String])[0], (indexes as! [String])[1]))!
            } else {
                self.dateTo = dateFormatter.date(from: String(format: "%@-%@", (indexes as! [String])[0], (indexes as! [String])[1]))!
            }
            
        }, cancel: { picker in
            
        }, origin: cell)
        datePicker?.tapDismissAction = TapAction.cancel
        datePicker?.toolbarButtonsColor = .NTWBlue
        datePicker?.show()
    }
    
    private var months: [String] {
        return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    }
    
    private func years(from: Int) -> [String] {
        return (from...Date().year).map { String($0) }
    }
}


extension NTWAddWorkExperienceViewController: NTWSwitchCellDelegate {
    func `switch`(atCell cell: UITableViewCell, didChangeValue isOn: Bool) {
        self.isMyCurrentWork = isOn
        if isOn {
            self.addExperienceTableView.deleteRows(at: [IndexPath(row: 6, section: 0)], with: .top)
        } else {
            self.addExperienceTableView.insertRows(at: [IndexPath(row: 6, section: 0)], with: .top)
        }
    }
}

