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
    let sut = Result<String>.failure(reason: .pathAlreadyExists)

    // when / then
    XCTAssertNil(sut.value())
  }

  func testMapWithArgumentWhenFailure() {
    // given
    let sut = Result<Int>.failure(reason: .pathAlreadyExists)
    let success: (Int) -> (Result<String>) = {
      .success(value: "Marcin\($0)")
    }

    // when
    let result = sut.map(success)

    // then
    XCTAssertEqual(Result<String>.failure(reason: .pathAlreadyExists), result)

    // for pure sake of 100% code coverage
    XCTAssertEqual(Result.success(value: "Marcin24"), success(24))
  }

  func testMapWithArgumentWhenSuccess() {
    // given
    let sut = Result.success(value: 24)
    let success: (Int) -> (Result<String>) = {
      .success(value: "Marcin\($0)")
    }

    // when
    let result = sut.map(success)

    // then
    XCTAssertEqual(Result.success(value: "Marcin24"), result)

    // for pure sake of 100% code coverage
    XCTAssertEqual(Result.success(value: "Marcin24"), success(24))
  }

  func testMapWithoutArgumentWhenFailure() {
    // given
    let sut = Result<Int>.failure(reason: .pathAlreadyExists)
    let success: () -> (Result<String>) = {
      .success(value: "Marcin")
    }

    // when
    let result = sut.map(success)

    // then.
    XCTAssertEqual(Result<String>.failure(reason: .pathAlreadyExists), result)

    // for pure sake of 100% code coverage
    XCTAssertEqual(Result.success(value: "Marcin"), success())
  }

  func testMapWithoutArgumentWhenSuccess() {
    // given
    let sut = Result.success(value: 24)

    // when
    let result = sut.map {
      .success(value: "Marcin")
    }

    // then
    XCTAssertEqual(Result.success(value: "Marcin"), result)
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

  func testEqualWhenBothNotADirectoryFailures() {
    // given
    let t1 = Result<String>.failure(reason: .notADirectory)
    let t2 = Result<String>.failure(reason: .notADirectory)

    // when / then
    XCTAssertTrue(t1 == t2)
  }
}
