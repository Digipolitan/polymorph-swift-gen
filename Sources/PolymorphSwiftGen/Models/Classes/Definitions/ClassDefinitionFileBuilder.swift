//
//  ClassDefinitionFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import SwiftCodeWriter

struct ClassDefinitionFileBuilder: ClassFileBuilder {

    public static let `default` = ClassDefinitionFileBuilder()

    private init() { }

    func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        if element.injectable || element.serializable {
            return try ClassInterfaceDefinitionFileBuilder.default.build(element: element, options: options)
        }
        return try ClassDefaultDefinitionFileBuilder.default.build(element: element, options: options)
    }
}
