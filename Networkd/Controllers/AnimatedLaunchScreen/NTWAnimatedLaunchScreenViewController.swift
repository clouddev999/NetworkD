//
//  NTWAnimatedLaunchScreenViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/12/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

class NTWAnimatedLaunchScreenViewController: UIViewController {

    var interactor: SignInInteractor?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = SignInInteractor.createInstance(typeThing: SignInInteractor.self , view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if self.interactor?.fetchSessionUser() != nil {
            let controller = storyboard.instantiateViewController(withIdentifier: "newsViewController")
            self.navigationController?.setViewControllers([controller], animated: true)
        } else {
            let controller = storyboard.instantiateViewController(withIdentifier: "signInViewController")
            self.navigationController?.setViewControllers([controller], animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension NTWAnimatedLaunchScreenViewController: BaseView {
    func onError(error: ITError) {}
    func onSuccess(object: AnyObject) {}
}
