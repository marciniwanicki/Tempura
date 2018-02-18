//
//  XCTestCase+Result.swift
//  Tests-iOS
//
//  Created by Marcin Iwanicki on 15/02/2018.
//

import Foundation
import XCTest
@testable import Tempura

extension XCTestCase {

    func reason(_ error: Error) -> Reason {
        guard let result = error as? Reason else {
            fatalError("Error is not an instance of Result")
        }
        return result
    }
}
