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
        self.builders.append(ClassDefinitionFileBuilder())
        self.builders.append(ClassImplementationFileBuilder())
     }

    public func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        return try self.builders.map { try $0.build(element: element, options: options) }.reduce([], { return $0 + $1 })
    }
}
