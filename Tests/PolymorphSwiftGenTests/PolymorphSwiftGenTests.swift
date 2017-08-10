import XCTest
@testable import PolymorphSwiftGen

class PolymorphSwiftGenTests: XCTestCase {

    func testWriteEmptyFile() {
        let fileDescription = SwiftFileDescription()
        XCTAssertEqual("", SwiftFileWriter.default.write(fileDescription: fileDescription))
    }

    func testWriteOnlyDocumentationFile() {
        let fileDescription = SwiftFileDescription(documentation: "SwiftPlatformGen.swift\nPolymorphSwiftGen\n\nCreated by Benoit BRIATTE on XX/XX/XXXX.")
        XCTAssertEqual("//\n//  SwiftPlatformGen.swift\n//  PolymorphSwiftGen\n//\n//  Created by Benoit BRIATTE on XX/XX/XXXX.\n//\n", SwiftFileWriter.default.write(fileDescription: fileDescription))
    }

    static var allTests = [
        ("testWriteEmptyFile", testWriteEmptyFile),
        ("testWriteOnlyDocumentationFile", testWriteOnlyDocumentationFile)
    ]
}
