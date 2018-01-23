//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class FileSystem {

    enum Error {
        case pathAlreadyExists
    }

    enum Result: Equatable {
        case success
        case error(reason: Error)

        static func == (lhs: Result, rhs: Result) -> Bool {
            switch (lhs, rhs) {
                case (.success, .success): return true
                case let (.error(reason: l), .error(reason: r)): return l == r
                default: return false
            }
        }
    }

    private static let rootInodeId: Int = 1

    private let directories: Directories
    private let inodes: Inodes

    private var inodeIdCounter: Int = FileSystem.rootInodeId

    init() {
        self.inodes = Inodes()
        self.inodes.add(self.inodeIdCounter, Inode(type: .directory))

        self.directories = Directories(rootInodeId: self.inodeIdCounter)
    }

    func exists(path: String) -> Bool {
        return lookupInode(path: path) != nil
    }

    func lookupInode(path: String) -> Inode? {
        guard let inodeId = lookupInodeId(path: path) else {
            return nil
        }

        return self.inodes.inode(by: inodeId)
    }

    func createDirectory(path: String, createIntermediates: Bool = false) -> Result {
        guard !exists(path: path) else {
            return Result.error(reason: .pathAlreadyExists)
        }

        let inode = Inode(type: .directory)
        return addInode(inode, path: path)
    }

    private func lookupInodeId(path: String) -> Int? {
        let separator = String(UnixPath.separator)
        guard path.starts(with: separator) else {
            return nil
        }

        if path == separator {
            return FileSystem.rootInodeId
        }

        let components = path.split(separator: UnixPath.separator)
        var inodeId = FileSystem.rootInodeId
        for component in components {
            let inodesDictionary = self.directories.list(inodeId: inodeId)
            guard let subinodeId = inodesDictionary?[String(component)] else {
                return nil
            }
            inodeId = subinodeId
        }
        return inodeId
    }

    private func addInode(_ inode: Inode, path: String) -> Result {
        return .success
    }

    private func generateInodeId() -> Int {
        self.inodeIdCounter += 1
        return self.inodeIdCounter
    }
}
