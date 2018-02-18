//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class Directories {

  private var list = [Int: [String: Int]]()

  init(rootInodeId: Int) {
    self.list[rootInodeId] = createDirectory(inodeId: rootInodeId, parentInodeId: rootInodeId)
  }

  func list(inodeId: Int) -> [String: Int]? {
    return self.list[inodeId]
  }

  func add(inode: (inodeId: Int, filename: String), parentInodeId: Int, directory: Bool = false) throws  {
    guard var parentDirectory = self.list[parentInodeId] else {
      throw Reason.inodeNotFound
    }

    parentDirectory[inode.filename] = inode.inodeId

    self.list[parentInodeId] = parentDirectory
    self.list[inode.inodeId] = createDirectory(inodeId: inode.inodeId, parentInodeId: parentInodeId)
  }

  private func createDirectory(inodeId: Int, parentInodeId: Int) -> [String: Int] {
    var list = [String: Int]()
    list["."] = inodeId
    list[".."] = parentInodeId
    return list
  }
}
