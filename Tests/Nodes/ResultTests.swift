//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class ResultTests: XCTestCase {

  func testIsSuccessWithSuccess() {
    // given
    let sut = Result.success

    // when / then
    XCTAssertTrue(sut.isSuccess())
  }

  func testIsSuccessWithFailure() {
    // given
    let sut = Result.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(sut.isSuccess())
  }

  func testEqualWhenSuccessAndSuccess() {
    // given
    let t1 = Result.success
    let t2 = Result.success

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenFailureAndSuccess() {
    // given
    let t1 = Result.success
    let t2 = Result.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenTheSameFailures() {
    // given
    let t1 = Result.failure(reason: .pathAlreadyExists)
    let t2 = Result.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentFailures() {
    // given
    let t1 = Result.failure(reason: .pathAlreadyExists)
    let t2 = Result.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(t1 == t2)
  }
}
