import Foundation

struct DecodingContext {
  let usingAlternateKeys: Bool = false
}

private let contextKey = CodingUserInfoKey(rawValue: "context")!

extension JSONDecoder {
  var context: DecodingContext? {
    get { userInfo[contextKey] as? DecodingContext }
    set { userInfo[contextKey] = newValue }
  }
}

extension Decoder {
  var context: DecodingContext? {
    userInfo[contextKey] as? DecodingContext
  }
}
