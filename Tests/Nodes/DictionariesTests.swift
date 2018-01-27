//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class DictionariesTests: XCTestCase {

  func testListWhenRootOnly() {
    // given
    let sut = Directories(rootInodeId: 1)
    let expected = [".": 1, "..": 1]

    // when / then
    XCTAssertEqual(expected, sut.list(inodeId: 1)!)
  }

  func testAddRootSubdirectory() {
    // given
    let sut = Directories(rootInodeId: 1)

    // when
    let result = sut.add(inode: (2, "filename"), parentInodeId: 1)

    // then
    XCTAssertEqual(Result.success(value: 2), result)
    XCTAssertEqual([".": 1, "..": 1, "filename": 2], sut.list(inodeId: 1)!)
  }

  func testAddWhenParentDoesNotExist() {
    // given
    let sut = Directories(rootInodeId: 1)

    // when
    let result = sut.add(inode: (2, "filename"), parentInodeId: 3)

    // then
    XCTAssertEqual(Result.failure(reason: .inodeNotFound), result)
  }
}
