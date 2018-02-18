//
// Created by Marcin Iwanicki on 27/01/2018.
//

import Foundation
@testable import Tempura

class FileSystemMock: FileSystem {

  typealias CreateDirectoryParameters = (path: String, intermediateDirectories: Bool)

  private(set) var createDirectoryCalls = [CreateDirectoryParameters]()

  override func createDirectory(path string: String,
                                withIntermediateDirectories intermediateDirectories: Bool = false,
                                attributes: [FileAttributeKey: Any]? = nil) throws {
    self.createDirectoryCalls.append((path: string, intermediateDirectories: intermediateDirectories))
  }
}
