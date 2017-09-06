//
//  ClassObjectMapperDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

struct ClassObjectMapperDescriptionBuilder: ClassDescriptionBuilder {

    public static let `default` = ClassObjectMapperDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ClassDescription) throws {
        if element.extends == nil {
            description.implements.append("Mappable")
            description.modules.append("ObjectMapper")
        }
        if let initializer = try ClassMappableInitializerBuilder.default.build(element: element) {
            description.initializers.append(initializer)
        }
        if let mapping = try ClassMappingMethodBuilder.default.build(element: element) {
            description.methods.append(mapping)
        }
    }
}
