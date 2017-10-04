//
//  ClassObjectMapperTransformerBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter

public struct ObjectMapperTransformMethod {
    public let type: String
    public let code: CodeBuilder
    public let modules: [String]

    public init(type: String, code: CodeBuilder, modules: [String] = []) {
        self.type = type
        self.code = code
        self.modules = modules
    }
}

public protocol ClassObjectMapperTransformerBuilder {
    func build(property: Property) throws -> ObjectMapperTransformMethod
}

extension ClassObjectMapperTransformerBuilder {

    public static func mergeOptions(of property: Property) -> [Transformer.Option] {
        guard let project = property.project,
            let propertyTransformer = property.mapping?.transformer,
            let projectTransformer = project.transformers[propertyTransformer.id] else {
            return []
        }
        return projectTransformer.options.map { option in
            if let propertyOption = projectTransformer.options.first(where: { $0.name == option.name }) {
                return propertyOption
            }
            return option
        }
    }
}
