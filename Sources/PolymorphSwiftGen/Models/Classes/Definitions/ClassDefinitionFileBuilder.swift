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

class ClassDefinitionFileBuilder: ClassFileBuilder {

    public static let shared = ClassDefinitionFileBuilder()

    private init() { }

    func build(element: Class, options: PolymorphGen.Options) throws -> [File] {
        if element.injectable || element.serializable {
            return try InterfaceDefinitionClassFileBuilder.shared.build(element: element, options: options)
        }
        return try DefaultDefinitionClassFileBuilder.shared.build(element: element, options: options)
    }
}
