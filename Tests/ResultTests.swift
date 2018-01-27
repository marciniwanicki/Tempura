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

  func testEqualWhenTheSameSuccess() {
    // given
    let t1 = Result<String>.success(value: "A")
    let t2 = Result<String>.success(value: "A")

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentSuccess() {
    // given
    let t1 = Result<String>.success(value: "A")
    let t2 = Result<String>.success(value: "B")

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenFailureAndSuccess() {
    // given
    let t1 = Result<String>.success(value: "A")
    let t2 = Result<String>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenTheSameFailures() {
    // given
    let t1 = Result<String>.failure(reason: .pathAlreadyExists)
    let t2 = Result<String>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentFailures() {
    // given
    let t1 = Result<String>.failure(reason: .pathAlreadyExists)
    let t2 = Result<String>.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(t1 == t2)
  }
}
