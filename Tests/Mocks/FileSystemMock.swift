//
// Created by Marcin Iwanicki on 27/01/2018.
//

import Foundation
@testable import Tempura

class FileSystemMock: FileSystem {

  typealias CreateDirectoryParameters = (path: String, createIntermediates: Bool)

  private(set) var createDirectoryCalls = [CreateDirectoryParameters]()

  override func createDirectory(path string: String, createIntermediates: Bool = false) -> ResultValue<String> {
    self.createDirectoryCalls.append((path: string, createIntermediates: createIntermediates))
    return ResultValue.success(value: string)
  }
}
