//
// Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

class Inodes {

    private var list = [Int: Inode]()

    func add(_ inodeId: Int, _ inode: Inode) {
        self.list[inodeId] = inode
    }
}
