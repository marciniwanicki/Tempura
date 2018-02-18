//
// Created by Marcin Iwanicki on 23/01/2018.
//

import Foundation

enum Reason: Error {
  case invalidPath(path: String)
  case pathAlreadyExists
  case inodeNotFound
  case notADirectory
  case operationNotAllowed
}

extension Reason: Equatable {

  static func == (lhs: Reason, rhs: Reason) -> Bool {
    switch (lhs, rhs) {
    case let (.invalidPath(path:l), .invalidPath(path:r)): return l == r
    case (.pathAlreadyExists, .pathAlreadyExists): return true
    case (.inodeNotFound, .inodeNotFound): return true
    case (.notADirectory, .notADirectory): return true
    case (.operationNotAllowed, .operationNotAllowed): return true
    default: return false
    }
  }
}
