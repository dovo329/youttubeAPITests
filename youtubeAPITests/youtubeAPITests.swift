//
//  youtubeAPITests.swift
//  youtubeAPITests
//
//  Created by Douglas Voss on 8/14/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

import UIKit
import XCTest

class youtubeAPITests: XCTestCase {
    
    var dut : ViewController = ViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dut.videoId = "KYVdf5xyD8I"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testNetwork() {
        let completionExpectation = expectationWithDescription("networkTimeout")
        
        let commentQuery = baseURL+"commentThreads?part=snippet"+"&videoId="+dut.videoId+"&key="+googleAPIKey
        
        dut.queryWithUrlString(commentQuery, isTest:true, completion: {(Void) -> Void in
            println("test completion fired")
            completionExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(3.0, handler: nil)
        /*XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
        [self.vcToTest doSomethingThatTakesSomeTimesWithCompletionBlock:^(NSString *result) {
        XCTAssertEqualObjects(@"result", result, @"Result was not correct!");
        [completionExpectation fulfill];
        }];
        [self waitForExpectationsWithTimeout:5.0 handler:nil];*/
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
