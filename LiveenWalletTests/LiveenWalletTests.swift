//
//  LiveenWalletTests.swift
//  LiveenWalletTests
//
//  Created by 이도현 on 2018. 5. 8..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import XCTest

class LiveenWalletTests: XCTestCase {
    var veenAPI:VeenAPI? = nil
    
    override func setUp() {
        guard let api = try? VeenAPI() else {
            return;
        }
        veenAPI = api
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateAccount() {
        guard let account = try? veenAPI!.createAccount() else {
            XCTAssert(1 == 2)
            return;
        }
        
        XCTAssertNotNil(account)
        XCTAssertNotNil(account.publicAddress)
        
        print(account.publicAddress)
    }
    
    func testGetVeen() {
        do {
            let balance = try veenAPI!.getCurentVeen()
            XCTAssert(balance == 0)
            
            print("-----------")
            print("my veen: \(balance)")
            print("-----------")
        } catch {
            print("Error occured. \(error)")
        }
    }
}
