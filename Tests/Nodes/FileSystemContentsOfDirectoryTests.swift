//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemContentsOfDirectoryTests: XCTestCase {

  private var sut = FileSystem()

  override func setUp() {
    sut = FileSystem()
  }

  func testContentsOfDirectoryWhenInvalidPath() {
    // when
    let result = sut.contentsOfDirectory(atPath: "invalidPath///",
        includingPropertiesForKeys: nil,
        options: Foundation.FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

    // then
    XCTAssertEqual(ResultSequence.failure(reason: .invalidPath(path: "invalidPath///")), result)
  }

  func testContentsOfDirectoryWhenEmptyRoot() {
    // when
    let result = sut.contentsOfDirectory(atPath: "/",
        includingPropertiesForKeys: nil,
        options: Foundation.FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

    // then
    XCTAssertEqual(ResultSequence.success(value: []), result)
  }

  func testContentsOfDirectoryWhenContainsTwoDirectories() {
    // given
    sut.createDirectory(path: "/A")
    sut.createDirectory(path: "/B")

    // when
    let result = sut.contentsOfDirectory(atPath: "/",
        includingPropertiesForKeys: nil,
        options: Foundation.FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

    // then
    XCTAssertEqual(ResultSequence.success(value: ["/A", "/B"]), result)
  }

  func testContentsOfDirectoryWhenSubdirectoryDoesNotExist() {
    // given
    sut.createDirectory(path: "/A")

    // when
    let result = sut.contentsOfDirectory(atPath: "/A/B",
        includingPropertiesForKeys: nil,
        options: Foundation.FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

    // then
    XCTAssertEqual(ResultSequence.failure(reason: .inodeNotFound), result)
  }
}
