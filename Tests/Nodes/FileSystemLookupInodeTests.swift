//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemLookupInodeTests: XCTestCase {

  func testLookupInodeForEmptyPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .invalidPath(path: "")), sut.lookupInode(path: ""))
  }

  func testLookupInodeForRootPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.success(value: Inode(type: .directory)), sut.lookupInode(path: "/"))
  }

  func testLookupInodeForExistingPath() {
    // given
    let sut = Tempura.FileSystem()
    _ = sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(ResultValue.success(value: Inode(type: .directory)), sut.lookupInode(path: "/testme"))
  }

  func testLookupInodeForNotExistingPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .inodeNotFound), sut.lookupInode(path: "/testme"))
  }

  func testCreateDirectoryRootPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/"))
  }

  func testCreateDirectoryInvalidPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .invalidPath(path: "invalidPath/file.txt")),
        sut.createDirectory(path: "invalidPath/file.txt"))
  }

  func testCreateDirectoryValidPath() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.success(value: "/testme"), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryValidPathWithIntermediates() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.success(value: "/testme/testme2/testme3"),
        sut.createDirectory(path: "/testme/testme2/testme3", createIntermediates: true))
  }

  func testCreateDirectoryPathAlreadyExistsAndNoSubdirectory() {
    // given
    let sut = Tempura.FileSystem()
    _ = sut.createDirectory(path: "/testme")

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .pathAlreadyExists), sut.createDirectory(path: "/testme"))
  }

  func testCreateDirectoryParentPathDoesExist() {
    // given
    let sut = Tempura.FileSystem()

    // when / then
    XCTAssertEqual(ResultValue.failure(reason: .invalidPath(path: "/test")),
        sut.createDirectory(path: "/test/test.txt"))
  }
}
