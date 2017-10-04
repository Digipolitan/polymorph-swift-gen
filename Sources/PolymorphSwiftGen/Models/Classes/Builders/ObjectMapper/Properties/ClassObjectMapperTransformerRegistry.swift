//
//  ClassObjectMapperTransformerRegistry.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter

class ClassObjectMapperTransformerRegistry: ClassObjectMapperTransformerBuilder {

    private let registry: [String: ClassObjectMapperTransformerBuilder]

    public static let `default` = ClassObjectMapperTransformerRegistry()

    private init() {
        self.registry = [:]
    }

    func build(property: Property) throws -> ObjectMapperTransformMethod {
        guard
            let project = property.project,
            let propertyTransformer = property.mapping?.transformer,
            let projectTransformer = project.transformers[propertyTransformer.id] else {
            throw PolymorphSwiftGenError.malformatedProject
        }
        guard let transformerBuilder = self.registry[projectTransformer.name] else {
            throw PolymorphSwiftGenError.missingTransformerBuilder(name: projectTransformer.name)
        }
        return try transformerBuilder.build(property: property)
    }
}
