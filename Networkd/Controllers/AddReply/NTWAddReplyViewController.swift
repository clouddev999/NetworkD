//
//  NTWAddReplyViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/10/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class NTWAddReplyViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var repliesTableView: UITableView!
    @IBOutlet weak var replyTextField: SkyFloatingLabelTextField!
    
    
    // MARK: - UIViewController Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.repliesTableView.rowHeight = UITableViewAutomaticDimension
        self.repliesTableView.estimatedRowHeight = 20
        
        /*self.replyTextField.placeholderFont = UIFont.systemFont(ofSize: 14)
        self.replyTextField.font = UIFont.systemFont(ofSize: 15)
        self.replyTextField.delegate = self*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension NTWAddReplyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NTWNewsTableViewCell
            cell.userNameButton.setTitle("Andrea Franco", for: .normal)
            cell.positionCompanyLabel.text = "English Professor at Colombo Americano"
            cell.postTitleLabel.text = "How to Run a Successful Small Business"
            cell.setPostDescription(with: "It can be easy to start a small business, as there are opportunities to fit almost every budget and skill. It is often harder, however, to run a small business successfully. Running a successful smart business is a good a idea bla bla bla.")
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! NTWReplyTableViewCell
            cell.userNameButton.setTitle("Carlos Rios", for: .normal)
            cell.dateLabel.text = "21 hours ago"
            cell.setReply(with: "It can be easy to start a small business, as there are opportunities to fit almost every budget and skill. It is often harder, however, to run a small business successfully. Running a successful smart business is a good a idea bla bla bla.")
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

extension NTWAddReplyViewController: NTWNewsCellDelegate {
    
    func expand(postCell cell: UITableViewCell) {
        self.repliesTableView.beginUpdates()
        self.repliesTableView.endUpdates()
    }
    
    func showPostOptions(forCell cell: UITableViewCell) {
        
        //let indexPath = self.newsTableView.indexPath(for: cell)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let reportAction = UIAlertAction(title: "Report", style: .default) { UIAlertAction in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let removeNewsAction = UIAlertAction(title: "Remove News", style: .default) { UIAlertAction in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in }
        
        alert.addAction(reportAction)
        alert.addAction(removeNewsAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func didTapLikeButton(atPostCell cell: UITableViewCell) {
        
    }
    
    func didTapReplyButton(atPostCell cell: UITableViewCell) {
        
    }
}

extension NTWAddReplyViewController: NTWReplyCellDelegate {
    
    func expand(replyCell: UITableViewCell) {
        self.repliesTableView.beginUpdates()
        self.repliesTableView.endUpdates()
    }
    
    func showReplyOptions(forCell cell: UITableViewCell) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let reportAction = UIAlertAction(title: "Report", style: .default) { UIAlertAction in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let removeReplyAction = UIAlertAction(title: "Remove Reply", style: .default) { UIAlertAction in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in }
        
        alert.addAction(reportAction)
        alert.addAction(removeReplyAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func didTapLikeButton(atReplyCell cell: UITableViewCell) {
        
    }
}


extension NTWAddReplyViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.repliesTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
}

