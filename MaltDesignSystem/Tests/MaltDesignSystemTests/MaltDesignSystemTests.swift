import XCTest
@testable import MaltDesignSystem

final class MaltDesignSystemTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MaltDesignSystem.shared.fontToken.title.fontName, "MaltDesignSystem.FontName.Moderat.bold")
    }
}
