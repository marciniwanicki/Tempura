//
//  FileManager.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 20/01/2018.
//

import Foundation

public protocol FileManager {

    @available(iOS 5.0, *)
    func createDirectory(at url: URL,
                         withIntermediateDirectories createIntermediates: Bool,
                         attributes: [FileAttributeKey : Any]?) throws
}
