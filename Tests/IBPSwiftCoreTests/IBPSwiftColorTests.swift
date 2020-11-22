import XCTest
@testable import IBPSwiftCore

final class IBPSwiftColorTests: XCTestCase {
    
    func testColorRedEqual() {
        let color = IBPSwiftCore.Color.fromHex("#FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func testIBPSwiftColorAreEqual() {
        let color = IBPSwiftCore.Color.fromHex("006736")
        XCTAssertEqual(color, IBPSwiftCore.Color.ibpColor)
    }
    
    func testSecondIBPSwioftColorAreEqual() {
        let color = IBPSwiftCore.Color.fromHex("FCFFFD")
        XCTAssertEqual(color, IBPSwiftCore.Color.secondIbpColor)
    }

    static var allTests = [
        ("testColorRedEqual", testColorRedEqual),
        ("testIBPSwiftColorAreEqual", testIBPSwiftColorAreEqual),
        ("testSecondIBPSwioftColorAreEqual", testSecondIBPSwioftColorAreEqual)
    ]
}
