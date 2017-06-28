//
//  BaseInteractorTest.swift
//  Networkd
//
//  Created by Carlos Rios on 5/10/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import XCTest
@testable import Networkd
class BaseInteractorTest: NetworkdTestSuite {
    
    var adapter: NetworkFake?
    var cloud:Cloud?
    var local:LocalFake?
    var repo:Repo?
    var presenter: BasePresenter?
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.adapter = NetworkFake()
        self.cloud = Cloud(adapter: self.adapter!)
        self.local = LocalFake()
        self.repo = Repo(local:self.local!,cloud: self.cloud!)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
