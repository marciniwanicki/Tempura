//
// Created by Marcin Iwanicki on 11/02/2018.
//

import Foundation

class Files {

  private var list = [Int: Data]()

  func data(inodeId: Int) -> Data? {
    return self.list[inodeId]
  }

  func saveData(inodeId: Int, data: Data) {
    self.list[inodeId] = data
  }

  func clearData(inodeId: Int) {
    guard let index = self.list.index(forKey: inodeId) else {
      return
    }
    self.list.remove(at: index)
  }
}
