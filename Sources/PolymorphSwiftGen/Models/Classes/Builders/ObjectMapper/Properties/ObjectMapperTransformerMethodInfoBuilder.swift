//
//  ClassObjectMapperTransformerBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter

struct ObjectMapperTransformerMethodInfo {
    public let type: String
    public let code: CodeBuilder
    public let modules: [String]

    public init(type: String, code: CodeBuilder, modules: [String] = []) {
        self.type = type
        self.code = code
        self.modules = modules
    }
}

protocol ObjectMapperTransformerMethodInfoBuilder {
    func build(property: Property) throws -> ObjectMapperTransformerMethodInfo
}

extension ObjectMapperTransformerMethodInfoBuilder {

    public static func mergeOptions(of property: Property) -> [String: Transformer.Option] {
        var options: [String: Transformer.Option] = [:]
        guard let project = property.project,
            let propertyTransformer = property.mapping?.transformer,
            let projectTransformer = project.transformers[propertyTransformer.id] else {
                return options
        }
        projectTransformer.options.forEach { option in
            if let propertyOption = projectTransformer.options.first(where: { $0.name == option.name }) {
                options[propertyOption.name] = propertyOption
            } else {
                options[option.name] = option
            }
        }
        return options
    }
}
