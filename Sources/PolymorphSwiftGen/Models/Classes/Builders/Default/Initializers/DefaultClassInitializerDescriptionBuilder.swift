//
//  DefaultClassInitializerDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class DefaultClassInitializerDescriptionBuilder: ClassInitializerDescriptionBuilder {

    public static let shared = DefaultClassInitializerDescriptionBuilder()

    private init() { }

    public func build(element: Class) throws -> InitializerDescription? {
        var arguments: [String] = []
        let impl = CodeBuilder()

        let parentProperties = element.parentProperties()
        var modules = Set<String>()
        let hasParentProperties = parentProperties.count > 0
        var override = false
        if hasParentProperties {
            override = true
            var superArguments: [String] = []
            for property in parentProperties {
                if property.isNonnull || (property.isConst && property.defaultValue == nil) {
                    var type = try Mapping.shared.platformType(with: property)
                    if !property.isNonnull {
                        type += "? = nil"
                    }
                    modules.formUnion(try Mapping.shared.modules(with: property))
                    arguments.append("\(property.name): \(type)")
                    superArguments.append("\(property.name): \(property.name)")
                }
            }
            impl.add(line: "super.init(\(superArguments.joined(separator: ", ")))")
        }
        for property in element.properties {
            if property.isNonnull || (property.isConst && property.defaultValue == nil) {
                var type = try Mapping.shared.platformType(with: property)
                if !property.isNonnull {
                    type += "? = nil"
                }
                modules.formUnion(try Mapping.shared.modules(with: property))
                arguments.append("\(property.name): \(type)")
                impl.add(line: "self.\(property.name) = \(property.name)")
                if hasParentProperties {
                    override = false
                }
            }
        }
        return InitializerDescription(code: impl, options: .init(visibility: .public, isOverride: override), modules: Array(modules), arguments: arguments)
    }
}
