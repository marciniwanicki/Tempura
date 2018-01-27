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
    let url = URL(string: "/file.txt")!
    let sut = TempuraFileManager(fileSystem: fileSystemMock)

    // when
    do {
      try sut.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
    } catch let exception {
      XCTFail("Unexpected exception \(exception)")
    }

    // then
    let fsCalls = fileSystemMock.createDirectoryCalls
    XCTAssertEqual(1, fsCalls.count)
    XCTAssertEqual("/file.txt", fsCalls[0].path)
    XCTAssertEqual(false, fsCalls[0].createIntermediates)
  }
}
