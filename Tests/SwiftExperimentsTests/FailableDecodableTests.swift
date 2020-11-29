// https://martiancraft.com/blog/2020/03/going-deep-with-decodable/

import Foundation
import XCTest

@testable import SwiftExperiments

final class FailableDecodableTests: XCTestCase {
  let decoder = JSONDecoder()

  func testFailableDecode() throws {
    let json = """
               [
                 {
                   "name": "name1"
                 },
                 {
                   "name": "name2",
                   "age": 42,               
                 }
               ]
               """.data(using: .utf8)!

    struct User: Codable {
      let name: String
      let age: Int
    }

    let result = try? decoder.decode([User].self, from: json)
    XCTAssertNil(result)

    let result2 = try decoder.decode([FailableDecodable<User>].self, from: json).compactMap { $0.decoded }
    XCTAssertEqual(result2.count, 1)
    XCTAssertNotNil(result2[0].name)
    XCTAssertNotNil(result2[0].age)
  }
}
