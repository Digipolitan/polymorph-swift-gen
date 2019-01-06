//
//  ClassInitializerDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 24/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class ObjectMapperClassInitializerDescriptionBuilder: ClassInitializerDescriptionBuilder {

    public static let shared = ObjectMapperClassInitializerDescriptionBuilder()

    private init() { }

    public func build(element: Class) throws -> InitializerDescription? {
        guard let project = element.project else {
            return nil
        }
        let impl = CodeBuilder()
        var modules = Set<String>()
        modules.insert("ObjectMapper")

        var guards: [String] = []
        var assigns: [String] = []
        var hasTransformers = false
        for property in element.properties {
            if let mapping = property.mapping, mapping.isIgnored {
                continue
            }
            if property.isNonnull {
                if property.mapping?.transformer != nil {
                    hasTransformers = true
                }
                let map = try self.transformNonnullProperty(property, project: project)
                modules.formUnion(try Mapping.shared.modules(with: property))
                guards.append(map.0)
                assigns.append(map.1)
            }
            if property.isConst && property.defaultValue == nil {
                if property.mapping?.transformer != nil {
                    hasTransformers = true
                }
                assigns.append("self.\(property.name) = \(try self.valueMapping(property, project: project))")
            }
        }
        if hasTransformers {
            impl.add(line: "let selfClass = type(of: self)")
        }
        let count = guards.count
        if count > 0 {
            impl.add(line: "guard").rightTab()
            let last = count - 1
            for idx in 0...last {
                var line = guards[idx]
                if idx != last {
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

    private func transformNonnullProperty(_ property: Property, project: Project) throws -> (String, String) {
        let assign = "self.\(property.name) = \(property.name)"
        let platformType = try Mapping.shared.platformType(with: property)
        return ("let \(property.name): \(platformType) = \(try self.valueMapping(property, project: project))", assign)
    }

    private func valueMapping(_ property: Property, project: Project) throws -> String {
        let type = try Mapping.model(with: property)
        if let clazz = type as? Class {
            if clazz.injectable || clazz.serializable {
                return self.valueMapping(property, injectedClass: clazz)
            }
        } else if type.name == Native.DataType.array.rawValue, let gts = property.genericTypes, gts.count > 0 {
            let genericType = try Mapping.model(with: gts[0], project: project)
            if let genType = genericType as? Class {
                if genType.injectable || genType.serializable {
                    return self.valueMapping(property, injectedClass: genType)
                }
            }
        }
        return self.defaultValueMapping(property)
    }

    private func valueMapping(_ property: Property, injectedClass: Class) -> String {
        return "try? map.injectedValue(\"\(property.mapping?.key ?? property.name)\", type: \(injectedClass.name).self)"
    }

    private func defaultValueMapping(_ property: Property) -> String {
        var value = "try? map.value(\"\(property.mapping?.key ?? property.name)\""
        if property.mapping?.transformer != nil {
            value += ", using: selfClass.\(property.name)Transformer"
        }
        value += ")"
        return value
    }
}
