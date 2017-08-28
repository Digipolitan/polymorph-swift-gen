//
//  ClassFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen

public protocol ClassFileBuilder {
    func build(element: Class, options: PlatformGen.Options) throws -> [File]
}
