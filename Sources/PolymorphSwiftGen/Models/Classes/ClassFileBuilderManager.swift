//
//  ClassFileBuilderManager.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen

struct ClassFileBuilderManager: ClassFileBuilder {

    public static let `default` = ClassFileBuilderManager()

    private var builders: [ClassFileBuilder] = []

    private init() {
        self.builders.append(ClassDefinitionFileBuilder.default)
        self.builders.append(ClassImplementationFileBuilder.default)
     }

    public func build(element: Class, options: PolymorphGen.Options) throws -> [File] {
        return try self.builders.map { try $0.build(element: element, options: options) }.reduce([], { return $0 + $1 })
    }
}
