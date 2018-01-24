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
      return .failure(reason: .invalidPath)
    }

    return lookupInode(path: path)
  }

  func createDirectory(path string: String, createIntermediates: Bool = false) -> Result<String> {
    guard let path = UnixPath(path: string) else {
      return .failure(reason: .invalidPath)
    }
    guard !exists(path: path) else {
      return .failure(reason: .pathAlreadyExists)
    }

    let inode = Inode(type: .directory)
    let result = addInode(inode, path: path)
    switch result {
    case .success: return .success(value: string)
    case let .failure(reason:r): return .failure(reason: r)
    }
  }

  private func exists(path: UnixPath) -> Bool {
    return lookupInode(path: path).isSuccess()
  }

  private func lookupInode(path: UnixPath) -> Result<Inode> {
    let result = lookupInodeId(path: path)
    switch result {
    case let .failure(reason:r): return .failure(reason: r)
    case let .success(value:v): return self.inodes.inode(by: v)
    }
  }

  private func lookupInodeId(path: UnixPath) -> Result<Int> {
    if path == UnixPath.root {
      return .success(value: FileSystem.rootInodeId)
    }

    var inodeId = FileSystem.rootInodeId
    for component in path.components() {
      let inodesDictionary = self.directories.list(inodeId: inodeId)
      guard let subinodeId = inodesDictionary?[component] else {
        return .failure(reason: .inodeNotFound)
      }
      inodeId = subinodeId
    }
    return .success(value: inodeId)
  }

  private func addInode(_ inode: Inode, path: UnixPath) -> Result<Int> {
    guard !lookupInode(path: path).isSuccess() else {
      return .failure(reason: .pathAlreadyExists)
    }

    let newInodeId = generateInodeId()
    self.inodes.add(newInodeId, inode)

    return .success(value: newInodeId)
  }

  private func generateInodeId() -> Int {
    self.inodeIdCounter += 1
    return self.inodeIdCounter
  }
}
