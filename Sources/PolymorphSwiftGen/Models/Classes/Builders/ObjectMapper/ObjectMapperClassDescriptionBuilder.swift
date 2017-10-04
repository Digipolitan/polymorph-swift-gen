//
//  ObjectMapperClassDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class ObjectMapperClassDescriptionBuilder: ClassDescriptionBuilder {

    public static let shared = ObjectMapperClassDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ClassDescription) throws {
        if element.extends == nil {
            description.implements.append("Mappable")
            description.modules.append("ObjectMapper")
        }
        let properties = try ObjectMapperTransformerClassPropertyDescriptionBuilder.shared.build(element: element)
        description.properties.append(contentsOf: properties)
        if let initializer = try ObjectMapperClassInitializerDescriptionBuilder.shared.build(element: element) {
            description.initializers.append(initializer)
        }
        if let mapping = try ObjectMapperMappingClassMethodDescriptionBuilder.shared.build(element: element) {
            description.methods.append(mapping)
        }
    }
}
