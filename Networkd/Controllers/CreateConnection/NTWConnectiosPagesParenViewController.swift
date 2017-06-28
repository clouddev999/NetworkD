//
//  NTWConnectiosPagesParenViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/12/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

class NTWConnectiosPagesParentViewController: UIViewController {

    var pageIndex: Int!
    
    
    @IBOutlet weak var connectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.connectionsTableView.rowHeight = UITableViewAutomaticDimension
        self.connectionsTableView.estimatedRowHeight = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension NTWConnectiosPagesParentViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectionCell", for: indexPath) as! NTWConnectionTableViewCell
        if pageIndex != 2 {
            cell.hideMeLabel.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
