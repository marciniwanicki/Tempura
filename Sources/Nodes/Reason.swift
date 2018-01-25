//
// Created by Marcin Iwanicki on 23/01/2018.
//

import Foundation

enum Reason {
  case invalidPath(path: String)
  case pathAlreadyExists
  case inodeNotFound
}

extension Reason: Equatable {

  static func == (lhs: Reason, rhs: Reason) -> Bool {
    switch (lhs, rhs) {
    case let (.invalidPath(path:l), .invalidPath(path:r)): return l == r
    case (.pathAlreadyExists, .pathAlreadyExists): return true
    case (.inodeNotFound, .inodeNotFound): return true
    default: return false
    }
  }
}
