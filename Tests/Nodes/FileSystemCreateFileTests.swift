//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemCreateFileTests: XCTestCase {

  private var sut = Tempura.FileSystem()
  private var inodes = Inodes()
  private var directories = Directories(rootInodeId: Tempura.FileSystem.rootInodeId)
  private var files = Files()

  override func setUp() {
    inodes = Inodes()
    inodes.add(FileSystem.rootInodeId, Inode(type: .directory))
    directories = Directories(rootInodeId: Tempura.FileSystem.rootInodeId)
    files = Files()
    sut = Tempura.FileSystem(inodes: inodes, directories: directories, files: files)
  }

  func testCreateFileWithInvalidPath() {
    // when
    let result = sut.createFile(atPath: "invalidPath/file.txt", contents: nil)

    // then
    XCTAssertEqual(Result.failure(reason: .invalidPath(path: "invalidPath/file.txt")), result)
  }

  func testCreateFileWhenPathAlreadyExists() {
    // given
    sut.createDirectory(path: "/A")

    // when
    let result = sut.createFile(atPath: "/A", contents: nil)

    // then
    XCTAssertEqual(Result.failure(reason: .pathAlreadyExists), result)
  }

  func testCreateFileInRootDirectory() {
    // when
    let result = sut.createFile(atPath: "/A", contents: nil)

    // then
    XCTAssertEqual(Result.success, result)
  }
}
