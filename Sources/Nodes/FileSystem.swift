//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class FileSystem {

  static let rootInodeId: Int = 1

  fileprivate let directories: Directories
  fileprivate let files: Files
  fileprivate let inodes: Inodes

  fileprivate var inodeIdCounter: Int = FileSystem.rootInodeId

  init(inodes: Inodes, directories: Directories, files: Files) {
    self.inodes = inodes
    self.directories = directories
    self.files = files
  }

  convenience init() {
    let inodes = Inodes()
    inodes.add(FileSystem.rootInodeId, Inode(type: .directory))

    let directories = Directories(rootInodeId: FileSystem.rootInodeId)
    let files = Files()

    self.init(inodes: inodes, directories: directories, files: files)
  }

  func exists(path string: String) -> Bool {
    do {
      let path = try unixPath(from: string)
      _ = try inodeId(by: path)
      return true
    } catch {
      return false
    }
  }

  func createDirectory(path string: String,
                       withIntermediateDirectories intermediateDirectories: Bool = false,
                       attributes: [FileAttributeKey: Any]? = nil) throws {
    let path = try unixPath(from: string)

    /**
    TODO: Not sure it that works fine, what happens if /not-ex/not-ex/exists, folders are created in higher directories?
    */
    if intermediateDirectories {
      try createIntermediates(path: path, attributes: attributes)
    }

    try createDirectory(path: path, attributes: attributes)
  }

  func createFile(atPath string: String,
                  contents data: Data?,
                  attributes attr: [FileAttributeKey: Any]? = nil) throws {
    let path = try unixPath(from: string)

    guard !exists(path: path) else {
      throw Reason.pathAlreadyExists
    }

    guard let parentPath = path.parent(), exists(path: parentPath) else {
      throw Reason.invalidPath(path: string)
    }

    let candidate = Inode(type: .file, attributes: attr)

    try addInode(candidate, path: path)
  }

  func removeItem(atPath string: String) throws {
    let path = try unixPath(from: string)
    _ = try self.inodeId(by: path)

    // TODO: Finish me
  }

  func replaceItem(at originalItemString: String,
                   withItemAt newItemString: String,
                   backupItemName: String?,
                   options: Foundation.FileManager.ItemReplacementOptions = []) throws {
    // TODO: Implement me!
  }

  func trashItem(at string: String) throws {
    // TODO: Implement me!
  }

  func contentsOfDirectory(atPath string: String,
                           includingPropertiesForKeys keys: [URLResourceKey]?,
                           options mask: Foundation.FileManager.DirectoryEnumerationOptions)
  throws -> [String] {
    guard let path = UnixPath(path: string) else {
      throw Reason.invalidPath(path: string)
    }

    guard let inodes = inodes(at: path) else {
      throw Reason.inodeNotFound
    }

    guard let inode = inodes["."], inode.type == .directory else {
      throw Reason.notADirectory
    }

    let result = inodes.map {
          $0.key
        }
        .filter {
          $0 != "." && $0 != ".."
        }
        .flatMap {
          let pathString = path.description + "/" + $0
          return UnixPath(path: pathString)?.description
        }
        .sorted()

    return result
  }

  private func createIntermediates(path: Path, attributes: [FileAttributeKey: Any]?) throws {
    var toCreateStack = [Path]()
    var currentPath = path.parent()
    while let unwrappedCurrentPath = currentPath {
      if !exists(path: unwrappedCurrentPath) {
        toCreateStack.append(unwrappedCurrentPath)
      }
      currentPath = unwrappedCurrentPath.parent()
    }
    for currentPath in toCreateStack.reversed() {
      try createDirectory(path: currentPath, attributes: attributes)
    }
  }

  private func inodes(at path: Path) -> [String: Inode]? {
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
          mutableResult[tuple.key] = self.inodes.inode(by: tuple.value)!
          return mutableResult
        }

    guard !list.isEmpty else {
      return nil
    }

    return list
  }

  private func exists(path: Path) -> Bool {
    do {
      _ = try inode(by: path)
    } catch {
      return false
    }
    return true
  }

  private func createDirectory(path: Path, attributes: [FileAttributeKey: Any]?) throws {
    let inode = Inode(type: .directory, attributes: attributes)

    try addInode(inode, path: path)
  }

  private func addInode(_ inode: Inode, path: Path) throws {
    guard !exists(path: path) else {
      throw Reason.pathAlreadyExists
    }

    let parentPath = path.parent()!
    let parentNodeId = try inodeId(by: parentPath)
    let newInodeId = generateInodeId()

    try self.directories.add(inode: (inodeId: newInodeId, filename: path.lastComponent()), parentInodeId: parentNodeId)

    self.inodes.add(newInodeId, inode)
  }

  private func removeInode(_ inodeId: Int) throws {
    guard let inode = inodes.inode(by: inodeId) else {
      throw Reason.inodeNotFound
    }

    self.inodes.remove(inodeId)
    if inode.type == .file {
      self.files.clearData(inodeId: inodeId)
    }
    if inode.type == .directory {
      // TODO: Implement removing directories!
    }
  }

  private func generateInodeId() -> Int {
    self.inodeIdCounter += 1
    return self.inodeIdCounter
  }
}

extension FileSystem {

  fileprivate func unixPath(from string: String) throws -> UnixPath {
    guard let unixPath = UnixPath(path: string) else {
      throw Reason.invalidPath(path: string)
    }
    return unixPath
  }

  fileprivate func inode(by path: Path) throws -> Inode {
    let inodeId = try self.inodeId(by: path)
    return try inode(by: inodeId)
  }

  fileprivate func inode(by inodeId: Int) throws -> Inode {
    guard let inode = self.inodes.inode(by: inodeId) else {
      throw Reason.inodeNotFound
    }
    return inode
  }

  fileprivate func inodeId(by path: Path) throws -> Int {
    if path.parent() == nil {
      return FileSystem.rootInodeId
    }

    var inodeId = FileSystem.rootInodeId
    let components = path.components()

    for i in 0..<components.count - 1 {
      let next = components[i + 1]
      let inodesDictionary = self.directories.list(inodeId: inodeId)

      guard let subInodeId = inodesDictionary?[next] else {
        throw Reason.inodeNotFound
      }

      inodeId = subInodeId
    }

    return inodeId
  }
}
