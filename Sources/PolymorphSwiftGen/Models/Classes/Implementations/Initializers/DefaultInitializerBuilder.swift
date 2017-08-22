//
//  DefaultInitializerBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

struct DefaultInitializerBuilder: ClassInitializerDescriptionBuilder {

    public func build(element: Class) throws -> InitializerDescription? {
        var arguments: [String] = []
        let impl = CodeBuilder()

        let parentProperties = element.parentProperties()
        var modules = Set<String>()
        if parentProperties.count > 0 {
            var superArguments: [String] = []
            for property in parentProperties {
                if property.isNonnull {
                    let type = try Mapping.shared.platformType(with: property)
                    modules.formUnion(try Mapping.shared.modules(with: property))
                    arguments.append("\(property.name): \(type)")
                    superArguments.append("\(property.name): \(property.name)")
                }
            }
            impl.add(line: "super.init(\(superArguments.joined(separator: ", ")))")
        }
        for property in element.properties {
            if property.isNonnull {
                let type = try Mapping.shared.platformType(with: property)
                modules.formUnion(try Mapping.shared.modules(with: property))
                arguments.append("\(property.name): \(type)")
                impl.add(line: "self.\(property.name) = \(property.name)")
            }
        }
        return InitializerDescription(code: impl, options: .init(visibility: .public), modules: Array(modules), arguments: arguments)
    }
}
