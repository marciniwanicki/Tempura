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

  func lookupInode(path string: String) -> ResultValue<Inode> {
    return ResultValue(UnixPath(path: string), .invalidPath(path: string))
        .map(lookupInode)
  }

  func createDirectory(path string: String, createIntermediates: Bool = false) -> ResultValue<String> {
    return ResultValue(UnixPath(path: string), .invalidPath(path: string))
        .map { [unowned self] in
          if createIntermediates {
            self.createIntermediates(path: $0)
          }

          return createDirectory(path: $0)
        }
  }

  func contentsOfDirectory(atPath string: String,
                           includingPropertiesForKeys keys: [URLResourceKey]?,
                           options mask: Foundation.FileManager.DirectoryEnumerationOptions)
          -> ResultSequence<[String]> {
    guard let path = UnixPath(path: string) else {
      return .failure(reason: .invalidPath(path: string))
    }

    let rootList = self.directories.list(inodeId: FileSystem.rootInodeId)!
    let list = path
        .components()
        .dropFirst()
        .reduce(rootList) { [unowned self] (inodeIdArray: [String: Int], component: String) in
          guard let guardInodeId = inodeIdArray["."],
                let guardNextList = self.directories.list(inodeId: guardInodeId),
                let guardNextInodeId = guardNextList[component],
                let list = self.directories.list(inodeId: guardNextInodeId) else {
            return [:]
          }
          return list
        }.reduce([String: Inode]()) { [unowned self] (result: [String: Inode], tuple: (key: String, value: Int)) in
          var mutableResult = result
          mutableResult[tuple.key] = self.inodes.inode(by: tuple.value).value()!
          return mutableResult
        }

    guard !list.isEmpty else {
      return .failure(reason: .inodeNotFound)
    }

    let inode = list["."]!

    guard inode.type == .directory else {
      return .failure(reason: .notADirectory)
    }

    let result = list.map { (key, _) in
          key
        }
        .filter {
          $0 != "." && $0 != ".."
        }
        .flatMap {
          let pathString = path.description + "/" + $0
          return UnixPath(path: pathString)?.description
        }
        .sorted()

    return ResultSequence.success(value: result)
  }

  private func createIntermediates(path: Path) {
    var toCreateStack = [Path]()
    var currentPath = path.parent()
    while let unwrappedCurrentPath = currentPath {
      if !exists(path: unwrappedCurrentPath) {
        toCreateStack.append(unwrappedCurrentPath)
      }
      currentPath = unwrappedCurrentPath.parent()
    }
    for currentPath in toCreateStack.reversed() {
      _ = createDirectory(path: currentPath)
    }
  }

  private func exists(path: Path) -> Bool {
    return lookupInode(path: path).isSuccess()
  }

  private func lookupInode(path: Path) -> ResultValue<Inode> {
    return lookupInodeId(path: path)
        .map(self.inodes.inode)
  }

  private func lookupInodeId(path: Path) -> ResultValue<Int> {
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

  func createDirectory(path: Path, createIntermediates: Bool = false) -> ResultValue<String> {
    return addInode(.directory, path: path)
        .map {
          .success(value: path.description)
        }
  }

  private func addInode(_ inode: Inode, path: Path) -> ResultValue<Int> {
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
