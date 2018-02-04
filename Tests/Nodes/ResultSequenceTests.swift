//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class ResultSequenceTests: XCTestCase {

  func testIsSuccessWithSuccess() {
    // given
    let sut = ResultSequence.success(value: ["test1", "test2"])

    // when / then
    XCTAssertTrue(sut.isSuccess())
  }

  func testIsSuccessWithFailure() {
    // given
    let sut = ResultSequence<[String]>.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(sut.isSuccess())
  }

  func testValueWhenSuccess() {
    // given
    let sut = ResultSequence.success(value: ["test1", "test2"])

    // when / then
    XCTAssertEqual(["test1", "test2"], sut.value()!)
  }

  func testValueWhenFailure() {
    // given
    let sut = ResultSequence<[String]>.failure(reason: Reason.pathAlreadyExists)

    // when / then
    XCTAssertNil(sut.value())
  }

  func testEqualWhenTheSameSuccess() {
    // given
    let t1 = ResultSequence<[String]>.success(value: ["A", "B"])
    let t2 = ResultSequence<[String]>.success(value: ["A", "B"])

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentSuccess() {
    // given
    let t1 = ResultSequence<[String]>.success(value: ["A", "C"])
    let t2 = ResultSequence<[String]>.success(value: ["A", "B"])

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenFailureAndSuccess() {
    // given
    let t1 = ResultSequence<[String]>.success(value: ["A"])
    let t2 = ResultSequence<[String]>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenTheSameFailures() {
    // given
    let t1 = ResultSequence<[String]>.failure(reason: .pathAlreadyExists)
    let t2 = ResultSequence<[String]>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentFailures() {
    // given
    let t1 = ResultSequence<[String]>.failure(reason: .pathAlreadyExists)
    let t2 = ResultSequence<[String]>.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(t1 == t2)
  }
}
