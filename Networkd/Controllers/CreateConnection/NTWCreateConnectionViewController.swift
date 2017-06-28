//
//  NTWCreateConnectionViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/12/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import HMSegmentedControl

class NTWCreateConnectionViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var pageViewController: UIPageViewController!
    var connectionsViewControllers: [UIViewController]!
    var currentPageIndex: Int!

    
    // MARK - IBOutles
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var containerView: UIView!

    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeSegmentedControl()
        self.configurePageViewController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.containerView.layoutIfNeeded()
        self.pageViewController?.view.frame = CGRect(origin: CGPoint.zero, size: self.containerView.frame.size)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Helper Methods
    
    private func customizeSegmentedControl() {
        self.segmentedControl.backgroundColor = UIColor.white
        self.segmentedControl.selectionIndicatorColor = .NTWBlue
        self.segmentedControl.selectionStyle = .box
        self.segmentedControl.selectionIndicatorHeight = 3
        self.segmentedControl.selectionIndicatorBoxOpacity = 0
        self.segmentedControl.isVerticalDividerEnabled = false
        self.segmentedControl.verticalDividerColor = .clear
        self.segmentedControl.selectionIndicatorLocation = .down
        self.segmentedControl.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 15)
        self.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.NTWBlue, NSFontAttributeName: font]
        self.segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.NTWGray, NSFontAttributeName: font]
        self.segmentedControl.sectionTitles = ["Suggest", "Missed", "For Hire", "All"]
        self.segmentedControl.addTarget(self, action: #selector(self.segmentedChanged(segmentedControl:)), for: .valueChanged)
    }
    
    private func configurePageViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.pageViewController = storyboard.instantiateViewController(withIdentifier: "connectionsPageViewController") as! UIPageViewController
        self.pageViewController?.delegate = self
        self.pageViewController?.dataSource = self
        
        self.connectionsViewControllers = []
        for index in 0...3 {
            self.connectionsViewControllers.append(self.viewController(at: index))
        }
        
        self.pageViewController.setViewControllers([connectionsViewControllers[0]],
                                                   direction: .forward, animated: true, completion: nil)
        self.currentPageIndex = 0
        self.containerView.addSubview(self.pageViewController.view)
        self.containerView.sendSubview(toBack: self.pageViewController.view)
    }
    
    
    // MARK: - HMSegmentedControl Methods
    
    func segmentedChanged(segmentedControl: HMSegmentedControl) {
        if segmentedControl.selectedSegmentIndex > self.currentPageIndex {
            self.pageViewController.setViewControllers([self.connectionsViewControllers[segmentedControl.selectedSegmentIndex]],
                                                       direction: .forward, animated: true, completion: nil)
        }
        if segmentedControl.selectedSegmentIndex < self.currentPageIndex {
            self.pageViewController.setViewControllers([self.connectionsViewControllers[segmentedControl.selectedSegmentIndex]],
                                                       direction: .reverse, animated: true, completion: nil)
        }
        self.currentPageIndex = segmentedControl.selectedSegmentIndex
    }
}


extension NTWCreateConnectionViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func viewController(at index: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "connectionsViewController") as! NTWConnectiosPagesParentViewController
        viewController.pageIndex = index
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! NTWConnectiosPagesParentViewController).pageIndex + 1
        if index == self.connectionsViewControllers?.count {
            return nil
        }
        return self.connectionsViewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! NTWConnectiosPagesParentViewController).pageIndex
        if index == 0 {
            return nil
        }
        index! -= 1
        return self.connectionsViewControllers[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.currentPageIndex = (self.pageViewController.viewControllers?.last as! NTWConnectiosPagesParentViewController).pageIndex
            self.segmentedControl.selectedSegmentIndex = self.currentPageIndex
        }
    }
}
