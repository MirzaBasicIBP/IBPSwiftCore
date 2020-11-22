//
//  IBPSwiftNetworkingTests.swift
//  IBPSwiftCoreTests
//
//  Created by Mirza Basic on 22/11/2020.
//

import XCTest
@testable import IBPSwiftCore

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    func get(from url: URL, completionsHandler: @escaping (Data?, Error?) -> Void) {
        completionsHandler(data, error)
    }
}

final class IBPSwiftNetworkingTests: XCTestCase {


    func testLoadDataCall() throws {
        let manager = IBPSwiftCore.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        
        let expetation = XCTestExpectation(description: "Caled for data")
        let data = Data([0, 1, 0, 1])
        let url = URL(fileURLWithPath: "url")
        session.data = data
        
        manager.loadData(from: url) { result in
            expetation.fulfill()
            switch result {
                case .success(let returnedData):
                    XCTAssertEqual(data, returnedData, "manger returned unexpected data")
                case .failure(let error):
                    XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        wait(for: [expetation], timeout: 5)
    }
    
    static var allTests = [
    ("testLoadDataCall", testLoadDataCall)]
}
