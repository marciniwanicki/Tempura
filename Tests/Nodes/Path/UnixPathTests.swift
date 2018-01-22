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
        // given
        let validPath = "/valid/path.txt"

        // when
        let path = UnixPath(path: validPath)

        // then
        XCTAssertNotNil(path)
    }

    func testCreateWhenPathIsInvalid() {
        // given
        let invalidPath = "invalidPath"

        // when
        let path = UnixPath(path: invalidPath)

        // then
        XCTAssertNil(path)
    }
}
