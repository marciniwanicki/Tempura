//
//  Path.swift
//  Tempura
//
//  Created by Marcin Iwanicki on 21/01/2018.
//

import Foundation

protocol Path {

    func lastComponent() -> String

    func components() -> [String]

    func parent() -> Path?
}
