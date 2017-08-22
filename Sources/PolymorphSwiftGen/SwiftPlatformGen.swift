//
//  SwiftPlatformGen.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import PolymorphCore
import PolymorphGen
import Foundation

public class SwiftPlatformGen: PlatformGen {

    public override func models(_ models: Models, options: PlatformGen.Options) throws -> [File] {
        return try models.classes.map { try ModelClassFileBuilderManager.default.build(element: $0, options: options) }.reduce([], { return $0 + $1 })
    }
}
