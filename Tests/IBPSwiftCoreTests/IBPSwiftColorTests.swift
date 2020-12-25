import XCTest
@testable import IBPSwiftCore

final class IBPSwiftColorTests: XCTestCase {
    
    func testColorRedEqual() {
        let color = UIColor.fromHex("#FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func testIBPSwiftColorAreEqual() {
        let color = UIColor.fromHex("006736")
        XCTAssertEqual(color, UIColor.ibpColor)
    }
    
    func testSecondIBPSwioftColorAreEqual() {
        let color = UIColor.fromHex("FCFFFD")
        XCTAssertEqual(color, UIColor.secondIbpColor)
    }

    static var allTests = [
        ("testColorRedEqual", testColorRedEqual),
        ("testIBPSwiftColorAreEqual", testIBPSwiftColorAreEqual),
        ("testSecondIBPSwioftColorAreEqual", testSecondIBPSwioftColorAreEqual)
    ]
}
