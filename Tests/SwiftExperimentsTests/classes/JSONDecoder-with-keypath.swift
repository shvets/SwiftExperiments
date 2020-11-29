import Foundation

let keyPathKey = CodingUserInfoKey(rawValue: "keyPath")!

extension JSONDecoder {
  private var keyPathToContainedType: [String] {
    set { userInfo[keyPathKey] = newValue }
    get { userInfo[keyPathKey] as? [String] ?? [] }
  }
}

extension JSONDecoder {
  func decode<T: Decodable>(_ contained: T.Type, from data: Data, keyPath: [String]) throws -> T {
    keyPathToContainedType = keyPath

    let container = try decode(DecodableContainer<T>.self, from: data)

    return container.contained
  }
}

extension Decoder {
  var keyPathToContainedType: [String]? {
    userInfo[keyPathKey] as? [String]
  }
}