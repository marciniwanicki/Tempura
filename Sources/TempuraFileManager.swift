//
//  TempuraFileManager.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 20/01/2018.
//

import Foundation

class TempuraFileManager: FileManager {

  private let fileSystem: FileSystem

  init(fileSystem: FileSystem) {
    self.fileSystem = fileSystem
  }

  func createDirectory(at url: URL,
                       withIntermediateDirectories createIntermediates: Bool,
                       attributes: [FileAttributeKey: Any]?) throws {
    try self.fileSystem.createDirectory(path: url.path,
        withIntermediateDirectories: createIntermediates,
        attributes: attributes)
  }

//
//  func contentsOfDirectory(at url: URL,
//                           includingPropertiesForKeys keys: [URLResourceKey]?,
//                           options mask: Foundation.FileManager.DirectoryEnumerationOptions = []) throws -> [URL] {
//    fatalError("contentsOfDirectory(url:keys:mask:) has not been implemented")
//  }
}
