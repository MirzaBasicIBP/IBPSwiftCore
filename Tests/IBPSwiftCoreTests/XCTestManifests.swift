import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IBPSwiftColorTests.allTests),
        testCase(IBPSwiftNetworkingTests.allTests)
    ]
}
#endif
