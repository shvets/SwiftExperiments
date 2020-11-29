import Foundation

enum FailableDecodable<T: Decodable>: Decodable {
  case decoded(T)
  case failed(Error)

  init(from decoder: Decoder) throws {
    do {
      let decoded = try T(from: decoder)
      self = .decoded(decoded)
    } catch {
      self = .failed(error)
    }
  }

  var decoded: T? {
    switch self {
    case .decoded(let decoded): return decoded
    case .failed: return nil
    }
  }
}