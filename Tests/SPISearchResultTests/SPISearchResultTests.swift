import CustomDump
import Foundation
import SPISearchResult
import XCTest

final class SPISearchResultTests: XCTestCase {
    static var isoDate: Date {
        do {
            // earlier mechanism using DateFormatter:
            //    let newFormatter = ISO8601DateFormatter()
            //    formatter.formatOptions = [.withInternetDateTime]
            //    let date = newFormatter.date(from: "2023-12-04T06:38:23Z")
            return try Date.ISO8601FormatStyle.iso8601.parse("2023-12-04T06:38:23Z")
        } catch {
            return Date.now
        }
    }

    let samplePackageResult = SearchResult.Package(id: .init(owner: "heckj", repository: "SPISearchResult"), name: "SPISearchResult", package_keywords: [], summary: "A package that defines the transfer objects to capture a collection of Search Results from Swift Package Index", stars: 1, has_docs: true, last_activity: isoDate)

    let expectedJSONString = """
    {"a":723364703,"d":true,"id":{"o":"heckj","r":"SPISearchResult"},"k":[],"n":"SPISearchResult","s":"A package that defines the transfer objects to capture a collection of Search Results from Swift Package Index","x":1}
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
