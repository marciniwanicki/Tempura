//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class FileSystem {

    enum Result {
        case success
        case error
    }

    private static let rootInodeId: Int = 1
    private static let componentsSeparartor = "/"

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

    private func lookupInodeId(path: String) -> Int? {
        guard path.starts(with: FileSystem.componentsSeparartor) else {
            return nil
        }

        guard let componentsSeparator = FileSystem.componentsSeparartor.first else {
            return nil
        }

        if path == FileSystem.componentsSeparartor {
            return FileSystem.rootInodeId
        }

        let components = path.split(separator: componentsSeparator)
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
        
        return .error
    }

    private func generateInodeId() -> Int {
        self.inodeIdCounter += 1
        return self.inodeIdCounter
    }
}
