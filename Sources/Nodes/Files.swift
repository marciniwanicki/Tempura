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
}
