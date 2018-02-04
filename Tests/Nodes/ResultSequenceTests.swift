//
// Created by Marcin Iwanicki on 04/02/2018.
//

import XCTest
@testable import Tempura

class ResultArrayTests: XCTestCase {

  func testIsSuccessWithSuccess() {
    // given
    let sut = ResultArray.success(value: ["test1", "test2"])

    // when / then
    XCTAssertTrue(sut.isSuccess())
  }
}
