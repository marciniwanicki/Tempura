//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemCreateDirectoryTests: XCTestCase {

  private var sut = Tempura.FileSystem()

  override func setUp() {
    sut = Tempura.FileSystem()
  }

  func testCreateDirectoryRootPath() {
    // when / then
    XCTAssertThrowsError(try sut.createDirectory(path: "/")) {
        XCTAssertEqual(.pathAlreadyExists, reason($0))
    }
  }

  func testCreateDirectoryInvalidPath() {
    // when / then
    XCTAssertThrowsError(try sut.createDirectory(path: "invalidPath/file.txt")) {
        XCTAssertEqual(.invalidPath(path: "invalidPath/file.txt"), reason($0))
    }
  }

  func testCreateDirectoryValidPath() {
    // when / then
    XCTAssertNoThrow(try sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryValidPathWithIntermediates() {
    // when / then
    XCTAssertNoThrow(try sut.createDirectory(path: "/testme/testme2/testme3", withIntermediateDirectories: true))
  }

  func testCreateDirectoryPathAlreadyExistsAndNoSubdirectory() {
    // given
    try? sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertThrowsError(try sut.createDirectory(path: "/testme")) {
        XCTAssertEqual(.pathAlreadyExists, reason($0))
    }
  }

  func testCreateDirectoryParentPathDoesExist() {
    // when / then
    XCTAssertThrowsError(try sut.createDirectory(path: "/test/test.txt")) {
        XCTAssertEqual(.inodeNotFound, reason($0))
    }
  }
}
