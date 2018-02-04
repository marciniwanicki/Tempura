//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class FileSystemContentsOfDirectoryTests: XCTestCase {

  func testContentsOfDirectoryWhenInvalidPath() {
    // given
    let sut = FileSystem()

    // when
    let result = sut.contentsOfDirectory(atPath: "invalidPath///",
        includingPropertiesForKeys: nil,
        options: Foundation.FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)

    // then
    XCTAssertEqual(ResultSequence.failure(reason: .invalidPath(path: "invalidPath///")), result)
  }
}
