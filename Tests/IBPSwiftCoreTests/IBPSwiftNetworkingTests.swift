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
    
    func post(with request: URLRequest, completionsHandler: @escaping (Data?, Error?) -> Void) {
        completionsHandler(data, error)
    }
}

struct MockData: Codable, Equatable {
    var id: Int
    var name: String
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
        
        manager.get(from: url) { result in
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
    
    func testSendDataCall() {
        let session = NetworkSessionMock()
        let manager = IBPSwiftCore.Networking.Manager()
        let sampleObject = MockData(id: 1, name: "Test")
        let dataObject = try? JSONEncoder().encode(sampleObject)
        session.data = dataObject
        manager.session = session
        let url = URL(fileURLWithPath: "url")
        let expetation = XCTestExpectation(description: "Send data")
        manager.post(to: url, body: sampleObject) { result in
            expetation.fulfill()
            switch result {
            case .success(let returnedData):
                    let returnedObject = try? JSONDecoder().decode(MockData.self, from: returnedData)
                    XCTAssertEqual(returnedObject, sampleObject)
                    break
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error resul")
            }
            
        }
        wait(for: [expetation], timeout: 5)
    }
    
    static var allTests = [
    ("testLoadDataCall", testLoadDataCall)]
}
