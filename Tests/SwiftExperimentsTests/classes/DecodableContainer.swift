import Foundation

final class DecodableContainer<Contained: Decodable>: Decodable {

  let contained: Contained

  // The dynamic CodingKey type mentioned above
  struct Key: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
      self.stringValue = stringValue
    }

    var intValue: Int? { nil }
    init?(intValue: Int) { nil }
  }

  init(from decoder: Decoder) throws {
    if let containerPath = decoder.keyPathToContainedType, containerPath.isEmpty == false {
      var keys: [Key] = containerPath.map {
        Key(stringValue: $0)!
      }

      let finalKey = keys.removeLast()
      var nextContainer = try decoder.container(keyedBy: Key.self)

      while keys.isEmpty == false {
        let next = keys.removeFirst()
        nextContainer = try nextContainer.nestedContainer(keyedBy: Key.self, forKey: next)
      }

      contained = try nextContainer.decode(Contained.self, forKey: finalKey)
    } else {
      contained = try Contained.init(from: decoder)
    }
  }
}