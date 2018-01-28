//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class TempuraFileManagerTests: XCTestCase {

  /**
  public func createDirectory(at url: URL,
                              withIntermediateDirectories createIntermediates: Bool,
                              attributes: [FileAttributeKey: Any]?) throws
                              */
  func testCreateFirstDirectoryWithoutIntermediates() {
    // given
    let fileSystemMock = FileSystemMock()
    let url = URL(string: "/dir1")!
    let sut = TempuraFileManager(fileSystem: fileSystemMock)

    // when
    try? sut.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)

    // then
    let fsCalls = fileSystemMock.createDirectoryCalls
    XCTAssertEqual(1, fsCalls.count)
    XCTAssertEqual("/dir1", fsCalls[0].path)
    XCTAssertEqual(false, fsCalls[0].createIntermediates)
  }

  func testCreateFirstDirectoryWithIntermediates() {
    // given
    let fileSystemMock = FileSystemMock()
    let url = URL(string: "/dir1/dir2/dir3")!
    let sut = TempuraFileManager(fileSystem: fileSystemMock)

    // when
    try? sut.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)

    // then
    let fsCalls = fileSystemMock.createDirectoryCalls
    XCTAssertEqual(1, fsCalls.count)
    XCTAssertEqual("/dir1/dir2/dir3", fsCalls[0].path)
    XCTAssertEqual(true, fsCalls[0].createIntermediates)
  }
}
