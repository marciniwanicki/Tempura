//
// Created by Marcin Iwanicki on 27/01/2018.
//

import XCTest
@testable import Tempura

class ResultValueTests: XCTestCase {

  func testIsSuccessWithSuccess() {
    // given
    let sut = ResultValue.success(value: "testme")

    // when / then
    XCTAssertTrue(sut.isSuccess())
  }

  func testIsSuccessWithFailure() {
    // given
    let sut = ResultValue<String>.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(sut.isSuccess())
  }

  func testValueWhenSuccess() {
    // given
    let sut = ResultValue.success(value: "testme")

    // when / then
    XCTAssertEqual("testme", sut.value())
  }

  func testValueWhenFailure() {
    // given
    let sut = ResultValue<String>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertNil(sut.value())
  }

  func testMapWithArgumentWhenFailure() {
    // given
    let sut = ResultValue<Int>.failure(reason: .pathAlreadyExists)
    let success: (Int) -> (ResultValue<String>) = {
      .success(value: "Marcin\($0)")
    }

    // when
    let result = sut.map(success)

    // then
    XCTAssertEqual(ResultValue<String>.failure(reason: .pathAlreadyExists), result)

    // for pure sake of 100% code coverage
    XCTAssertEqual(ResultValue.success(value: "Marcin24"), success(24))
  }

  func testMapWithArgumentWhenSuccess() {
    // given
    let sut = ResultValue.success(value: 24)
    let success: (Int) -> (ResultValue<String>) = {
      .success(value: "Marcin\($0)")
    }

    // when
    let result = sut.map(success)

    // then
    XCTAssertEqual(ResultValue.success(value: "Marcin24"), result)

    // for pure sake of 100% code coverage
    XCTAssertEqual(ResultValue.success(value: "Marcin24"), success(24))
  }

  func testMapWithoutArgumentWhenFailure() {
    // given
    let sut = ResultValue<Int>.failure(reason: .pathAlreadyExists)
    let success: () -> (ResultValue<String>) = {
      .success(value: "Marcin")
    }

    // when
    let result = sut.map(success)

    // then.
    XCTAssertEqual(ResultValue<String>.failure(reason: .pathAlreadyExists), result)

    // for pure sake of 100% code coverage
    XCTAssertEqual(ResultValue.success(value: "Marcin"), success())
  }

  func testMapWithoutArgumentWhenSuccess() {
    // given
    let sut = ResultValue.success(value: 24)

    // when
    let result = sut.map {
      .success(value: "Marcin")
    }

    // then
    XCTAssertEqual(ResultValue.success(value: "Marcin"), result)
  }

  func testEqualWhenTheSameSuccess() {
    // given
    let t1 = ResultValue<String>.success(value: "A")
    let t2 = ResultValue<String>.success(value: "A")

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentSuccess() {
    // given
    let t1 = ResultValue<String>.success(value: "A")
    let t2 = ResultValue<String>.success(value: "B")

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenFailureAndSuccess() {
    // given
    let t1 = ResultValue<String>.success(value: "A")
    let t2 = ResultValue<String>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenTheSameFailures() {
    // given
    let t1 = ResultValue<String>.failure(reason: .pathAlreadyExists)
    let t2 = ResultValue<String>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertTrue(t1 == t2)
  }

  func testEqualWhenDifferentFailures() {
    // given
    let t1 = ResultValue<String>.failure(reason: .pathAlreadyExists)
    let t2 = ResultValue<String>.failure(reason: .inodeNotFound)

    // when / then
    XCTAssertFalse(t1 == t2)
  }

  func testEqualWhenBothNotADirectoryFailures() {
    // given
    let t1 = ResultValue<String>.failure(reason: .notADirectory)
    let t2 = ResultValue<String>.failure(reason: .notADirectory)

    // when / then
    XCTAssertTrue(t1 == t2)
  }
}
