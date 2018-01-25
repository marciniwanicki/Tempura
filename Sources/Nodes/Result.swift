//
// Created by Marcin Iwanicki on 23/01/2018.
//

import Foundation

enum Result<T: Equatable>: Equatable {
    case success(value: T)
    case failure(reason: Reason)

    func isSuccess() -> Bool {
        switch self {
        case .success(value: _): return true
        default: return false
        }
    }

    func value() -> T? {
        switch self {
        case let .success(value:v): return v
        default: return nil
        }
    }

    static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.success(value:l), .success(value:r)): return l == r
        case let (.failure(reason:l), .failure(reason:r)): return l == r
        default: return false
        }
    }
}
