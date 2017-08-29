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

    func build(element: Class, to description: inout ClassDescription) throws {
        if element.extends == nil {
            description.implements.append("Mappable")
            description.modules.append("ObjectMapper")
        }
        if let initializer = try ClassMappableInitializerBuilder().build(element: element) {
            description.initializers.append(initializer)
        }
        if let mapping = try ClassMappingMethodBuilder().build(element: element) {
            description.methods.append(mapping)
        }
    }
}
