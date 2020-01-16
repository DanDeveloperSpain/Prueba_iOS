//
//  Prueba_iOSTests.swift
//  Prueba_iOSTests
//
//  Created by Daniel Pérez Parreño on 26/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import XCTest
@testable import Prueba_iOS

class Prueba_iOSTests: XCTestCase {
    
    var userConfigurator: UserConfigurator!
    var dummyWebsocketSessionManager = DummyWebsocketSessionManager()

    override func setUp() {
        userConfigurator = UserConfigurator(websocketApiService: dummyWebsocketSessionManager)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testUserConfigurator() {
        userConfigurator.getUser(completionHandler: {result in
            XCTAssertEqual(result, true)
            XCTAssertEqual(self.userConfigurator.user.userName, "user2")
        })
    }


}
