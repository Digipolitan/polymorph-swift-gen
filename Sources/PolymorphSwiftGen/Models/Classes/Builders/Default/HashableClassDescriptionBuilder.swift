//
//  HashableClassDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class HashableClassDescriptionBuilder: ClassDescriptionBuilder {

    public static let shared = HashableClassDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ClassDescription) throws {

        if element.extends == nil {
            description.implements.append("Hashable")
        }
        if let hashMethod = try HashableClassMethodDescriptionBuilder.shared.build(element: element) {
            description.methods.append(hashMethod)
        }
    }
}

private class HashableClassMethodDescriptionBuilder: ClassMethodDescriptionBuilder {

    fileprivate static let shared = HashableClassMethodDescriptionBuilder()

    private init() { }

    private static let primaryFilter = { (property: Property) -> Bool in
        return property.isPrimary
    }
    private static let hashableFilter = { (property: Property) -> Bool in
        if let propertyType = property.project?.models.findObject(uuid: property.type) {
            if let propertyTypeClass = propertyType as? Class {
                return propertyTypeClass.injectable == false
            }
        }
        return true
    }
    private static let hashProperty = { (property: Property) -> String in
        return "hasher.hash(self.\(property.name))"
    }

    func build(element: Class) throws -> MethodDescription? {
        let impl = CodeBuilder()
        let primaryProperties = element.properties
            .filter(HashableClassMethodDescriptionBuilder.primaryFilter)
            .filter(HashableClassMethodDescriptionBuilder.hashableFilter)
        let parentPrimaryProperties = element.parentProperties()
            .filter(HashableClassMethodDescriptionBuilder.primaryFilter)
            .filter(HashableClassMethodDescriptionBuilder.hashableFilter)
        let hasParent = element.extends != nil
        if parentPrimaryProperties.count > 0 {
            if primaryProperties.count <= 0 {
                return nil
            }
            impl.add(line: "super.hash(into: &hasher)")
            primaryProperties.map(HashableClassMethodDescriptionBuilder.hashProperty).forEach { impl.add(line: $0) }
        } else if primaryProperties.count > 0 {
            primaryProperties.map(HashableClassMethodDescriptionBuilder.hashProperty).forEach { impl.add(line: $0) }
        } else {
            if hasParent {
                impl.add(line: "super.hash(into: &hasher)")
            }
            element.properties
                .filter(HashableClassMethodDescriptionBuilder.hashableFilter)
                .map(HashableClassMethodDescriptionBuilder.hashProperty)
                .forEach { impl.add(line: $0) }
        }
        return MethodDescription(name: "hash", code: impl, options: .init(visibility: .public, isOverride: hasParent), arguments: ["into hasher: inout Hasher"])
    }
}
