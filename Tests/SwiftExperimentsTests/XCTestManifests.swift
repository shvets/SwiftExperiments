import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(SwiftExperimentsTests.allTests),
    ]
}
#endif
