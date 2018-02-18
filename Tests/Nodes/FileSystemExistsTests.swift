//
// Created by Marcin Iwanicki on 21/01/2018.
//

import XCTest
@testable import Tempura

class FileSystemExistsTests: XCTestCase {

  private var sut = Tempura.FileSystem()

  override func setUp() {
    sut = Tempura.FileSystem()
  }

  func testExistsRootDirectory() {
    // when / then
    XCTAssertTrue(sut.exists(path: "/"))
  }

  func testExistsWhenDirectoryDoesNotExist() {
    // when / then
    XCTAssertFalse(sut.exists(path: "/doesNotExist"))
  }

  func testExistsWhenUsingRelativePath() {
    // when / then
    XCTAssertFalse(sut.exists(path: "relative"))
  }

  func testExistsWhenDirectoryExists() {
    // given
    do {
        try sut.createDirectory(path: "/A")
    } catch {
        XCTFail("createDirectory thrown an error")
    }

    // when / then
    XCTAssertTrue(sut.exists(path: "/A"))
  }
}
