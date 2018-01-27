//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class ResultTests: XCTestCase {

  func testIsSuccessWithSuccess() {
    // given
    let sut = Result.success(value: "testme")

    // when / then
    XCTAssertTrue(sut.isSuccess())
  }

  func testIsSuccessWithFailure() {
    // given
    let sut = Result<String>.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(sut.isSuccess())
  }

  func testValueWhenSuccess() {
    // given
    let sut = Result.success(value: "testme")

    // when / then
    XCTAssertEqual("testme", sut.value())
  }

  func testValueWhenFailure() {
    // given
    let sut = Result<String>.failure(reason: Reason.pathAlreadyExists)

    // when / then
    XCTAssertNil(sut.value())
  }
}
