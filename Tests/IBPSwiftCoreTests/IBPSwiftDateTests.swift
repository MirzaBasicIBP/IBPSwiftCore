//
//  IBPSwiftDateTests.swift
//  IBPSwiftCoreTests
//
//  Created by Mirza Basic on 23/11/2020.
//

import XCTest
@testable import IBPSwiftCore

class IBPSwiftDateTests: XCTestCase {


    func testUtcFirstDateOn1970() throws {
        let date = Date(timeIntervalSince1970: 0).utcString()
        XCTAssertEqual(date, IBPSwiftCore.DateCore.utcFirstDateOn1970)
    }

    static var allTests = [("testUtcFirstDateOn1970", testUtcFirstDateOn1970)]

}
