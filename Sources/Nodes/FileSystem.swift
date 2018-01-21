//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class FileSystem {

    private let directories: Directories
    private let inodes: Inodes

    private var inodeIdCounter: Int = 1

    init() {
        self.inodes = Inodes()
        self.inodes.add(self.inodeIdCounter, Inode(type: .directory))

        self.directories = Directories(rootInodeId: self.inodeIdCounter)
    }

    func exists(path: String) -> Bool {
        return false
    }

    func lookupInode(path: String) -> Inode? {
        return nil
    }

    private func lookupInodeId(path: String) -> Int {
        return 0
    }

    private func generateInodeId() -> Int {
        self.inodeIdCounter += 1
        return self.inodeIdCounter
    }
}
