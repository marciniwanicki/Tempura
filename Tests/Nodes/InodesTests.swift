//
// Created by Marcin Iwanicki on 26/01/2018.
//

import XCTest
@testable import Tempura

class InodesTests: XCTestCase {

  func testEqualWhenTheSame() {
    // when
    let sut = Inode(type: .directory)

    // then
    XCTAssertTrue(sut == Inode(type: .directory))
  }

  func testEqualWhenNotTheSame() {
    // when
    let sut = Inode(type: .directory)

    // then
    XCTAssertFalse(sut == Inode(type: .file))
  }
}
