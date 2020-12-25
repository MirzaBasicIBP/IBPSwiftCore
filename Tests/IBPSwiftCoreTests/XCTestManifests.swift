import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IBPSwiftColorTests.allTests),
        testCase(IBPSwiftDateTests.allTests),
    ]
}
#endif
