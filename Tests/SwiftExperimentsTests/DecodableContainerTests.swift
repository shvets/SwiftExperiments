// https://martiancraft.com/blog/2020/03/going-deep-with-decodable/

import Foundation
import XCTest

@testable import SwiftExperiments

final class DecodableContainerTests: XCTestCase {
  let decoder = JSONDecoder()

  func testPartialDecode() throws {
    let json = """
               {
                   "results": [{ "value": "value1" }],
                   "otherData": { "value": "value2" }
               }
               """.data(using: .utf8)!

    struct ResponseData: Codable {
      let value: String
    }

    struct ResponseContainer: Codable {
      let results: [ResponseData]
    }

    let response1 = try decoder.decode(ResponseContainer.self, from: json)

    XCTAssertEqual(response1.results[0].value, "value1")

    let response2 = try decoder.decode([ResponseData].self, from: json,  keyPath: ["results"])

    XCTAssertEqual(response2[0].value, "value1")
  }
}
