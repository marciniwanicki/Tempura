//
//  UnixPath.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

struct UnixPath: Path {

  static let separator: Character = "/"
  static let root = UnixPath(path: "/")

  private let pathComponents: [String]

  init?(path: String) {
    guard path.first == UnixPath.separator else {
      return nil
    }
    let pathComponents = path.split(separator: UnixPath.separator).map {
      String($0)
    }
    self.init(components: [String(UnixPath.separator)] + pathComponents)
  }

  private init?(components: [String]) {
    guard !components.isEmpty else {
      return nil
    }

    self.pathComponents = components
  }

  func lastComponent() -> String {
    return self.pathComponents.last!
  }

  func components() -> [String] {
    return self.pathComponents
  }

  func parent() -> Path? {
    return UnixPath(components: Array(self.pathComponents.dropLast()))
  }
}

extension UnixPath: Equatable {

  static func == (lhs: UnixPath, rhs: UnixPath) -> Bool {
    return lhs.components() == rhs.components()
  }
}

extension UnixPath: CustomStringConvertible {

  var description: String {
    return self.pathComponents.count == 1
        ? lastComponent()
        : String(components().joined(separator: String(UnixPath.separator)).dropFirst())
  }
}
