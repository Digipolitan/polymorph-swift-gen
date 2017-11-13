//
//  ClassTransformerPropertyBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class ObjectMapperTransformerClassPropertyDescriptionBuilder: ClassPropertyDescriptionBuilder {

    public static let shared = ObjectMapperTransformerClassPropertyDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> [PropertyDescription] {
        return try element.properties.filter { $0.mapping?.transformer != nil }.map({ (property) in
            let transformerMethod = try ObjectMapperTransformerMethodInfoBuilderRegistry.shared.build(property: property)
            let impl = CodeBuilder()
            impl.add(line: "{").rightTab().add(code: transformerMethod.code).leftTab().add(string: "}()", indent: true)
            return PropertyDescription(name: "\(property.name)Transformer",
                options: PropertyDescription.Options(getVisibility: .private, isStatic: true, isConstant: true),
                modules: transformerMethod.modules,
                type: transformerMethod.type,
                value: impl)
        })
    }
}
