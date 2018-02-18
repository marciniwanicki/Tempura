//
// Created by Marcin Iwanicki on 13/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemRemoveItemTests: XCTestCase {

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

//  func testRemoveItemWhenInvalidPath() {
//    // when
//    let result = sut.removeItem(atPath: "invalid/path")
//
//    // then
//    XCTAssertEqual(Result.failure(reason: .invalidPath(path: "invalid/path")), result)
//  }
//
//  func testRemoveItemWhenFileDoesNotExists() {
//    // when
//    let result = sut.removeItem(atPath: "/not-existing/path")
//
//    // then
//    XCTAssertEqual(Result.failure(reason: .inodeNotFound), result)
//  }
//
//  func testRemoveItemWhenRootDirectory() {
//    // when
//    let result = sut.removeItem(atPath: "/")
//
//    // then
//    XCTAssertEqual(Result.failure(reason: .operationNotAllowed), result)
//  }
//
//  func testRemoveItemDirectorySuccessfully() {
//    // given
//    sut.createDirectory(path: "/dir")
//
//    // when
//    let result = sut.removeItem(atPath: "/dir")
//
//    // then
//    XCTAssertEqual(Result.success, result)
//    XCTAssertEqual([".": 1, "..": 1], directories.list(inodeId: Tempura.FileSystem.rootInodeId)!)
//  }
//
//  func testRemoveItemFileSuccessfully() {
//    // given
//    sut.createFile(atPath: "/file.txt", contents: "Marcin".data(using: .utf8))
//
//    // when
//    let result = sut.removeItem(atPath: "/file.txt")
//
//    // then
//    XCTAssertEqual(Result.success, result)
//    XCTAssertNil(files.data(inodeId: 2))
//    XCTAssertEqual([".": 1, "..": 1], directories.list(inodeId: Tempura.FileSystem.rootInodeId)!)
//  }
}
