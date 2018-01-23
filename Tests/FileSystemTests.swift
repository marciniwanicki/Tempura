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

    func testExistsWhenDirectoryDoesNotExist() {
        // given
        let sut = Tempura.FileSystem()

        // when / then
        XCTAssertFalse(sut.exists(path: "/doesNotExist"))
    }

    func testExistsWhenUsingRelativePath() {
        // given
        let sut = Tempura.FileSystem()

        // when / then
        XCTAssertFalse(sut.exists(path: "relative"))
    }

    func testAddRootPath() {
        // given
        let sut = Tempura.FileSystem()

        // when / then
        XCTAssertEqual(FileSystem.Result.error(reason: .pathAlreadyExists), sut.createDirectory(path: "/"))
    }
}
