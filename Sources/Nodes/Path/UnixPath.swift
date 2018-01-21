//
//  UnixPath.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

struct UnixPath: Path {

    private let path: String

    init?(path: String) {
        self.path = path
    }

    func lastComponent() -> String {
        return ""
    }

    func components() -> [String] {
        return []
    }

    func parent() -> Path? {
        return nil
    }
}
