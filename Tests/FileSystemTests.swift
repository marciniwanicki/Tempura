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
}
