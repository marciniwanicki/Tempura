//
// Created by Marcin Iwanicki on 04/02/2018.
//

import Foundation

enum ResultSequence<T: Sequence>: Equatable where T.Element: Equatable {
  case success(value: T)
  case failure(reason: Reason)

  func isSuccess() -> Bool {
    switch self {
    case .success: return true
    default: return false
    }
  }

  func value() -> T? {
    switch self {
    case let .success(value:v): return v
    default: return nil
    }
  }

  static func == (lhs: ResultSequence<T>, rhs: ResultSequence<T>) -> Bool {
    switch (lhs, rhs) {
    case let (.success(value:l), .success(value:r)): return l.elementsEqual(r)
    case let (.failure(reason:l), .failure(reason:r)): return l == r
    default: return false
    }
  }
}
