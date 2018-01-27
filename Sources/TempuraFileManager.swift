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

  public func createDirectory(at url: URL,
                              withIntermediateDirectories createIntermediates: Bool,
                              attributes: [FileAttributeKey: Any]?) throws {
    _ = self.fileSystem.createDirectory(path: url.path, createIntermediates: createIntermediates)
  }
}
