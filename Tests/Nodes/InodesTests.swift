//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class InodesTests: XCTestCase {

  private var sut = Inodes()

  override func setUp() {
    sut = Inodes()
  }

  func testInodeWhenEmpty() {
    // when / then
    XCTAssertFalse(sut.inode(by: 0).isSuccess())
  }

  func testAddWhenEmpty() {
    // given
    let inode = Inode(type: .directory)

    // when
    sut.add(1, inode)

    // then
    XCTAssertTrue(sut.inode(by: 1).isSuccess())
  }

  func testAddWhenSameInodeIdIsAlreadyAdded() {
    // given
    let inode = Inode(type: .directory)
    let inode2 = Inode(type: .file)
    sut.add(1, inode)

    // when
    sut.add(1, inode2)

    // then
    XCTAssertEqual(inode2, sut.inode(by: 1).value())
  }
}
