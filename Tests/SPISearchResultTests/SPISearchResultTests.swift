import CustomDump
import Foundation
import SPISearchResult
import XCTest

final class SPISearchResultTests: XCTestCase {
    let samplePackageResult = SearchResult.Package(id: .init(owner: "heckj", repository: "SPISearchResult"), package_keywords: [], summary: "A package that defines the transfer objects to capture a collection of Search Results from Swift Package Index", stars: 1)

    let expectedJSONString = """
    {"id":{"o":"heckj","r":"SPISearchResult"},"k":[],"s":"A package that defines the transfer objects to capture a collection of Search Results from Swift Package Index","x":1}
    """

    func testJSONEncode() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let encodedPackage = try encoder.encode(samplePackageResult)
        let stringResult = try XCTUnwrap(String(data: encodedPackage, encoding: .utf8))
        // print(stringResult)
        XCTAssertEqual(stringResult, expectedJSONString)
    }
}
