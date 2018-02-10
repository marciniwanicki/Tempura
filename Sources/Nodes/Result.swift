//
// Created by Marcin Iwanicki on 23/01/2018.
//

import Foundation

enum Result<T: Equatable>: Equatable {
  case success(value: T)
  case failure(reason: Reason)

  func isSuccess() -> Bool {
    switch self {
    case .success(value: _): return true
    default: return false
    }
  }

  func value() -> T? {
    switch self {
    case let .success(value:v): return v
    default: return nil
    }
  }

  func map<U>(_ closure: () -> Result<U>) -> Result<U> {
    switch self {
    case let .failure(reason:r): return Result<U>.failure(reason: r)
    case .success: return closure()
    }
  }

  func map<U>(_ closure: (T) -> Result<U>) -> Result<U> {
    switch self {
    case let .failure(reason:r): return Result<U>.failure(reason: r)
    case let .success(value:t): return closure(t)
    }
  }

  static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
    switch (lhs, rhs) {
    case let (.success(value:l), .success(value:r)): return l == r
    case let (.failure(reason:l), .failure(reason:r)): return l == r
    default: return false
    }
  }
}
