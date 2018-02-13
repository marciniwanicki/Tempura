//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemLookupInodeTests: XCTestCase {

  private var sut = Tempura.FileSystem()

  override func setUp() {
    sut = Tempura.FileSystem()
  }

  func testLookupInodeForEmptyPath() {
    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .invalidPath(path: "")), sut.lookupInode(path: ""))
  }

  func testLookupInodeForRootPath() {
    // when / then
    XCTAssertEqual(ResultValue.success(value: Inode(type: .directory)), sut.lookupInode(path: "/"))
  }

  func testLookupInodeForExistingPath() {
    // given
    sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(ResultValue.success(value: Inode(type: .directory)), sut.lookupInode(path: "/testme"))
  }

  func testLookupInodeForNotExistingPath() {
    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .inodeNotFound), sut.lookupInode(path: "/testme"))
  }

  func testCreateDirectoryRootPath() {
    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/"))
  }

  func testCreateDirectoryInvalidPath() {
    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .invalidPath(path: "invalidPath/file.txt")),
        sut.createDirectory(path: "invalidPath/file.txt"))
  }

  func testCreateDirectoryValidPath() {
    // when / then
    XCTAssertEqual(ResultValue.success(value: "/testme"), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryValidPathWithIntermediates() {
    // when / then
    XCTAssertEqual(ResultValue.success(value: "/testme/testme2/testme3"),
        sut.createDirectory(path: "/testme/testme2/testme3", withIntermediateDirectories: true))
  }

  func testCreateDirectoryPathAlreadyExistsAndNoSubdirectory() {
    // given
    sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryParentPathDoesExist() {
    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .invalidPath(path: "/test")),
        sut.createDirectory(path: "/test/test.txt"))
  }
}
