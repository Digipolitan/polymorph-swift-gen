//
//  ClassMappableInitializerBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 24/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

struct ClassMappableInitializerBuilder: ClassInitializerDescriptionBuilder {

    public func build(element: Class) throws -> InitializerDescription? {
        guard let project = element.project else {
            return nil
        }
        let impl = CodeBuilder()
        var modules = Set<String>()
        modules.insert("ObjectMapper")

        var guards: [String] = []
        var assigns: [String] = []
        for property in element.properties {
            if property.isNonnull {
                let map = try self.mapNonnullProperty(property, project: project)
                modules.formUnion(try Mapping.shared.modules(with: property))
                guards.append(map.0)
                assigns.append(map.1)
            }
        }
        let count = guards.count
        if  count > 0 {
            impl.add(line: "guard").rightTab()
            let last = count - 1
            for i in 0...last {
                var line = guards[0]
                if i != last {
                    line += ","
                }
                impl.add(line: line)
            }
            impl.add(line: "else {").rightTab().add(line: "return nil").leftTab().leftTab().add(line: "}")
        }
        assigns.forEach { impl.add(line: $0) }
        if element.extends != nil {
            impl.add(line: "super.init(map: map)")
        }
        return InitializerDescription(code: impl, options: .init(visibility: .public, isOptional: true, isRequired: true), modules: Array(modules), arguments: ["map: Map"])
    }

    private func mapNonnullProperty(_ property: Property, project: Project) throws -> (String, String) {
        let assign = "self.\(property.name) = \(property.name)"
        let platformType = try Mapping.shared.platformType(with: property)
        let type = try Mapping.model(with: property)
        if let c = type as? Class {
            if c.injectable || c.serializable {
                return ("let \(property.name): \(platformType) = try? map.injectedValue(\"\(property.key ?? property.name)\", type: \(c.name).self)", assign)
            }
        } else if type.name == Native.DataType.array.rawValue, let gts = property.genericTypes, gts.count > 0 {
            let genericType = try Mapping.model(with: gts[0], project: project)
            if let c = genericType as? Class {
                if c.injectable || c.serializable {
                    return ("let \(property.name): \(platformType) = try? map.injectedValue(\"\(property.key ?? property.name)\", type: \(c.name).self)", assign)
                }
            }
        }
        return ("let \(property.name): \(platformType) = try? map.value(\"\(property.key ?? property.name)\")", assign)
    }
}
