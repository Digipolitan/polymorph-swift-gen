//
//  ObjectMapperTransformerMethodInfoBuilderRegistry.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter

class ObjectMapperTransformerMethodInfoBuilderRegistry: ObjectMapperTransformerMethodInfoBuilder {

    private let registry: [String: ObjectMapperTransformerMethodInfoBuilder]

    public static let shared = ObjectMapperTransformerMethodInfoBuilderRegistry()

    private init() {
        self.registry = [
            "timestamp": TimestampObjectMapperTransformerMethodInfoBuilder(),
            "date": DateObjectMapperTransformerMethodInfoBuilder(),
            "url": URLObjectMapperTransformerMethodInfoBuilder(),
            "multilingual": MultilingualStringObjectMapperTransformerMethodInfoBuilder()
        ]
    }

    func build(property: Property) throws -> ObjectMapperTransformerMethodInfo {
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
