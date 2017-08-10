import XCTest
@testable import PolymorphSwiftGen

class PolymorphSwiftClassGenTests: XCTestCase {

    func testWriteEmptyClass() {
        let classDescription = SwiftClassDescription(name: "Sample")
        XCTAssertEqual("", SwiftClassWriter.default.write(classDescription: classDescription))
    }

    static var allTests = [
        ("testWriteEmptyClass", testWriteEmptyClass)
    ]
}

