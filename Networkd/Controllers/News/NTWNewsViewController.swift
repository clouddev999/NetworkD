//
//  NTWNewsViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/9/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class NTWNewsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var newsTableView: UITableView!
    

    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.rowHeight = UITableViewAutomaticDimension
        self.newsTableView.estimatedRowHeight = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension NTWNewsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NTWNewsTableViewCell
        cell.userNameButton.setTitle("Andrea Franco", for: .normal)
        cell.positionCompanyLabel.text = "English Professor at Colombo Americano"
        cell.postTitleLabel.text = "How to Run a Successful Small Business"
        cell.setPostDescription(with: "It can be easy to start a small business, as there are opportunities to fit almost every budget and skill. It is often harder, however, to run a small business successfully. Running a successful smart business is a good a idea bla bla bla.")
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension NTWNewsViewController: NTWNewsCellDelegate {

    func expand(postCell cell: UITableViewCell) {
        self.newsTableView.beginUpdates()
        self.newsTableView.endUpdates()
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
        self.performSegue(withIdentifier: "toAddReply", sender: nil)
    }
    
}

