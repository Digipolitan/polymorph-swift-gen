//
//  ModelClassFileBuilderManager.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen

struct ModelClassFileBuilderManager: ModelClassFileBuilder {

    public static let `default` = ModelClassFileBuilderManager()

    private var builders: [ModelClassFileBuilder] = []

    private init() {
        self.builders.append(ModelClassDefinitionFileBuilder())
        self.builders.append(ModelClassImplementationFileBuilder())
     }

    public func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        return try self.builders.map { try $0.build(element: element, options: options) }.reduce([], { return $0 + $1 })
    }
}
