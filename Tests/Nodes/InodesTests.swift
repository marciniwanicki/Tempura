//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class InodesTests: XCTestCase {

  func testInodeWhenEmpty() {
    // given
    let sut = Inodes()

    // when / then
    XCTAssertFalse(sut.inode(by: 0).isSuccess())
  }

  func testAddWhenEmpty() {
    // given
    let sut = Inodes()
    let inode = Inode(type: .directory)

    // when
    sut.add(1, inode)

    // then
    XCTAssertTrue(sut.inode(by: 1).isSuccess())
  }

  func testAddWhenSameInodeIdIsAlreadyAdded() {
    // given
    let sut = Inodes()
    let inode = Inode(type: .directory)
    let inode2 = Inode(type: .file)
    sut.add(1, inode)

    // when
    sut.add(1, inode2)

    // then
    XCTAssertEqual(inode2, sut.inode(by: 1).value())
  }
}
