import XCTest
@testable import IBPSwiftCore

final class IBPSwiftCoreTests: XCTestCase {
    
    func testColorRedEqual() {
        let color = IBPSwiftCore.colorFromHex("#FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func testIBPSwiftColorAreEqual() {
        let color = IBPSwiftCore.colorFromHex("006736")
        XCTAssertEqual(color, IBPSwiftCore.ibpColor)
    }
    
    func testSecondIBPSwioftColorAreEqual() {
        let color = IBPSwiftCore.colorFromHex("FCFFFD")
        XCTAssertEqual(color, IBPSwiftCore.secondIbpColor)
    }

    static var allTests = [
        ("testColorRedEqual", testColorRedEqual),
        ("testIBPSwiftColorAreEqual", testIBPSwiftColorAreEqual)
    ]
}
