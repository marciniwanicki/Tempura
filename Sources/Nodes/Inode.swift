//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class Inode {

  enum InodeType {
    case directory
    case file
  }

  let type: InodeType
  let attributes: [FileAttributeKey: Any]?

  init(type: InodeType, attributes: [FileAttributeKey: Any]? = nil) {
    self.type = type
    self.attributes = attributes
  }
}

extension Inode: Equatable {

  static func == (lhs: Inode, rhs: Inode) -> Bool {
    return lhs.type == rhs.type
  }
}
