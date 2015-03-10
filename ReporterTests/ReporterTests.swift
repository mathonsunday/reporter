//
//  ReporterTests.swift
//  ReporterTests
//
//  Created by Veronica Ray on 2/20/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import XCTest
//import Reporter

class ReporterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // we can't do much  without a view on our root View Controller
    func testViewDidLoad()
    {
        let v = AddQuestionViewController()
        XCTAssertNotNil(v.view, "View Did Not load")
    }
    
    func popUpAppearsWhenUserClicksAdd() {
        
    }
    
    func questionThatHasBeenAddedAppearsInList() {
        
    }
    
    func popUpClosesWhenUserClicksCancel() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
