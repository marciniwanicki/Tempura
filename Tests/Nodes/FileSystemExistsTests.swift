//
// Created by Marcin Iwanicki on 21/01/2018.
//

import XCTest
@testable import Tempura

class FileSystemExistsTests: XCTestCase {

  func testExistsRootDirectory() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertTrue(sut.exists(path: "/"))
  }

  func testExistsWhenDirectoryDoesNotExist() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertFalse(sut.exists(path: "/doesNotExist"))
  }

  func testExistsWhenUsingRelativePath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertFalse(sut.exists(path: "relative"))
  }
}
