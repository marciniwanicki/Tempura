//
// Created by Marcin Iwanicki on 10/02/2018.
//

import Foundation

enum Result: Equatable {
  case success
  case failure(reason: Reason)

  func isSuccess() -> Bool {
    switch self {
    case .success: return true
    default: return false
    }
  }

  static func == (lhs: Result, rhs: Result) -> Bool {
    switch (lhs, rhs) {
    case (.success, .success): return true
    case let (.failure(reason:l), .failure(reason:r)): return l == r
    default: return false
    }
  }
}
