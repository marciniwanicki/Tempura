//
// Created by Marcin Iwanicki on 21/01/2018.
//

import XCTest
@testable import Tempura

class FileSystemTests: XCTestCase {

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

  func testCreateDirectoryRootPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/"))
  }

  func testCreateDirectoryInvalidPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.failure(reason: .invalidPath),
        sut.createDirectory(path: "invalidPath/file.txt"))
  }

  func testCreateDirectoryValidPathWithoutSubdirectory() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.success(value: "/testme"), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryValidPathWithoutSubdirectoryThatAlreadyExists() {
    // given
    let sut = Tempura.FileSystem()
    _ = sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(Result.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/testme"))
  }
}
