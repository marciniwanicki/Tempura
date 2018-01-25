//
//  UnixPathTests.swift
//  Tests-iOS
//
//  Created by Marcin Iwanicki on 21/01/2018.
//

import XCTest
@testable import Tempura

class UnixPathTests: XCTestCase {

  func testCreateWhenPathIsValid() {
    // when
    let sut = UnixPath(path: "/valid/path.txt")

    // then
    XCTAssertNotNil(sut)
  }

  func testCreateWhenPathIsInvalid() {
    // when
    let sut = UnixPath(path: "invalidPath")

    // then
    XCTAssertNil(sut)
  }

  func testLastComponentWhenPathToRootDirectory() {
    // given
    let sut = UnixPath(path: "/")

    // when / then
    XCTAssertEqual("/", sut?.lastComponent())
  }

  func testLastComponentWhenPathIsValid() {
    // given
    let sut = UnixPath(path: "/valid/path.txt")

    // when / then
    XCTAssertEqual("path.txt", sut?.lastComponent())
  }

  func testComponentsWhenPathToRootDirectory() {
    // given
    let sut = UnixPath(path: "/")

    // when / then
    XCTAssertEqual(["/"], sut?.components() ?? [])
  }

  func testComponentsWhenPathIsLonger() {
    // given
    let sut = UnixPath(path: "/dir1/dir2/file1.txt")

    // when / then
    XCTAssertEqual(["/", "dir1", "dir2", "file1.txt"], sut?.components() ?? [])
  }

  func testParentWhenPathToRootDirectory() {
    // given
    let sut = UnixPath(path: "/")

    // when / then
    XCTAssertNil(sut?.parent())
  }

  func testParentWhenPathIsLonger() {
    // given
    let sut = UnixPath(path: "/dir1/dir2/file1.txt")

    // when
    let parent = sut?.parent()

    // then
    XCTAssertEqual(["/", "dir1", "dir2"], parent?.components() ?? [])
  }

  func testEqualWhenDifferentPaths() {
    // given
    let path1 = UnixPath(path: "/path/file1.txt")
    let path2 = UnixPath(path: "/path/file2.txt")

    // when / then
    XCTAssertFalse(path1 == path2)
  }

  func testEqualWhenSamePaths() {
    // given
    let path1 = UnixPath(path: "/path/file.txt")
    let path2 = UnixPath(path: "/path/file.txt")

    // when / then
    XCTAssertTrue(path1 == path2)
  }
}
