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

  func testLookupInodeForEmptyPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.failure(reason: .invalidPath(path: "")), sut.lookupInode(path: ""))
  }

  func testLookupInodeForRootPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.success(value: Inode(type: .directory)), sut.lookupInode(path: "/"))
  }

  func testLookupInodeForExistingPath() {
    // given
    let sut = Tempura.FileSystem()
    _ = sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(Result.success(value: Inode(type: .directory)), sut.lookupInode(path: "/testme"))
  }

  func testLookupInodeForNotExistingPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.failure(reason: .inodeNotFound), sut.lookupInode(path: "/testme"))
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
    XCTAssertEqual(Result.failure(reason: .invalidPath(path: "invalidPath/file.txt")),
        sut.createDirectory(path: "invalidPath/file.txt"))
  }

  func testCreateDirectoryValidPathAndNoSubdirectory() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.success(value: "/testme"), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryPathAlreadyExistsAndNoSubdirectory() {
    // given
    let sut = Tempura.FileSystem()
    _ = sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(Result.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryParentPathDoesExist() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(Result.failure(reason: .invalidPath(path: "/test")), sut.createDirectory(path: "/test/test.txt"))
  }
}
