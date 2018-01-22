//
//  UnixPath.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

struct UnixPath: Path {

    static let separator: Character = "/"

    private let pathComponents: [String]

    init?(path: String) {
        self.pathComponents = path.split(separator: UnixPath.separator).map { String($0) }
        guard path.first == UnixPath.separator else {
            return nil
        }
    }

    func lastComponent() -> String {
        return ""
    }

    func components() -> [String] {
        return self.pathComponents
    }

    func parent() -> Path? {
        return nil
    }
}
