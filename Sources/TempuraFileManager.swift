//
//  TempuraFileManager.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 20/01/2018.
//

import Foundation

public class TempuraFileManager: FileManager {

    public init() {
    }

    public func me() -> String {
        return "Marcin"
    }

    public func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws {
        // nothing here yet
    }
}
