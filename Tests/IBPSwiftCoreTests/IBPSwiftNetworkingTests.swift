//
//  IBPSwiftNetworkingTests.swift
//  IBPSwiftCoreTests
//
//  Created by Mirza Basic on 22/11/2020.
//

import XCTest
@testable import IBPSwiftCore

final class IBPSwiftNetworkingTests: XCTestCase {


    func testLoadDataCall() throws {
        let manager = IBPSwiftCore.Networking.Manager()
        let expetation = XCTestExpectation(description: "Caled for data")
        guard let url = URL(string: "https://raywenderlich.com") else {
            return XCTFail("Could not create URL properly")
        }
        
        manager.loadData(from: url) { result in
            expetation.fulfill()
            switch result {
                case .success(let returnedData):
                    XCTAssertNil(returnedData, "Response data is nul")
                case .failure(let error):
                    XCTFail(error?.localizedDescription ?? "error forming error result")
                
            }
        }
        wait(for: [expetation], timeout: 5)
    }
    
    static var allTests = [
    ("testLoadDataCall", testLoadDataCall)]
}
