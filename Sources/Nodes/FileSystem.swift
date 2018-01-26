//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class FileSystem {

  private static let rootInodeId: Int = 1

  private let directories: Directories
  private let inodes: Inodes

  private var inodeIdCounter: Int = FileSystem.rootInodeId

  init() {
    self.inodes = Inodes()
    self.inodes.add(self.inodeIdCounter, Inode(type: .directory))

    self.directories = Directories(rootInodeId: self.inodeIdCounter)
  }

  func exists(path string: String) -> Bool {
    guard let path = UnixPath(path: string) else {
      return false
    }

    return exists(path: path)
  }

  func lookupInode(path string: String) -> Result<Inode> {
    guard let path = UnixPath(path: string) else {
      return .failure(reason: .invalidPath(path: string))
    }

    return lookupInode(path: path)
  }

  func createDirectory(path string: String, createIntermediates: Bool = false) -> Result<String> {
    guard let path = UnixPath(path: string) else {
      return .failure(reason: .invalidPath(path: string))
    }

    let inode = Inode(type: .directory)
    let result = addInode(inode, path: path)
    switch result {
    case .success: return .success(value: string)
    case let .failure(reason:r): return .failure(reason: r)
    }
  }

  private func exists(path: Path) -> Bool {
    return lookupInode(path: path).isSuccess()
  }

  private func lookupInode(path: Path) -> Result<Inode> {
    let result = lookupInodeId(path: path)
    switch result {
    case let .failure(reason:r): return .failure(reason: r)
    case let .success(value:v): return self.inodes.inode(by: v)
    }
  }

  private func lookupInodeId(path: Path) -> Result<Int> {
    if path.parent() == nil {
      return .success(value: FileSystem.rootInodeId)
    }

    var inodeId = FileSystem.rootInodeId
    let components = path.components()

    for i in 0..<components.count - 1 {
      let next = components[i + 1]
      let inodesDictionary = self.directories.list(inodeId: inodeId)

      guard let subinodeId = inodesDictionary?[next] else {
        return .failure(reason: .inodeNotFound)
      }

      inodeId = subinodeId
    }

    return .success(value: inodeId)
  }

  private func addInode(_ inode: Inode, path: Path) -> Result<Int> {
    guard !lookupInode(path: path).isSuccess() else {
      return .failure(reason: .pathAlreadyExists)
    }

    let parentPath: Path = path.parent()!

    guard let parentNodeId = lookupInodeId(path: parentPath).value() else {
      return .failure(reason: .invalidPath(path: parentPath.description))
    }

    let newInodeId = generateInodeId()

    // add operation cannot fail at that stage
    _ = self.directories.add(inode: (inodeId: newInodeId, filename: path.lastComponent()),
                             parentInodeId: parentNodeId)

    self.inodes.add(newInodeId, inode)

    return .success(value: newInodeId)
  }

  private func generateInodeId() -> Int {
    self.inodeIdCounter += 1
    return self.inodeIdCounter
  }
}
