//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class Inode {

  static let directory = Inode(type: .directory)

  enum InodeType {
    case directory
    case file
  }

  let type: InodeType

  init(type: InodeType) {
    self.type = type
  }
}

extension Inode: Equatable {

  static func == (lhs: Inode, rhs: Inode) -> Bool {
    return lhs.type == rhs.type
  }
}
