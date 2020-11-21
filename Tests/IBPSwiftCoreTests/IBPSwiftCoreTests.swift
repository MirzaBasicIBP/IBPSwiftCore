import XCTest
@testable import IBPSwiftCore

final class IBPSwiftCoreTests: XCTestCase {
    
    func testColorRedEqual() {
        let color = IBPSwiftCore.colorFromHex("#FF0000")
        XCTAssertEqual(color, .red)
    }

    static var allTests = [
        ("testColorRedEqual", testColorRedEqual),
    ]
}
