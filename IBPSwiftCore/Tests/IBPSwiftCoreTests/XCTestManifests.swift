import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IBPSwiftCoreTests.allTests),
    ]
}
#endif
