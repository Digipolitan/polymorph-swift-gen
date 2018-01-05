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
        let properties = try HashableClassPropertyDescriptionBuilder.shared.build(element: element)
        description.properties.append(contentsOf: properties)
    }
}

private class HashableClassPropertyDescriptionBuilder: ClassPropertyDescriptionBuilder {

    fileprivate static let shared = HashableClassPropertyDescriptionBuilder()

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
        if property.isNonnull {
            return "self.\(property.name).hashValue"
        }
        return "(self.\(property.name)?.hashValue ?? 0)"
    }

    func build(element: Class) throws -> [PropertyDescription] {
        let impl = CodeBuilder()
        let primaryProperties = element.properties
            .filter(HashableClassPropertyDescriptionBuilder.primaryFilter)
            .filter(HashableClassPropertyDescriptionBuilder.hashableFilter)
        let parentPrimaryProperties = element.parentProperties()
            .filter(HashableClassPropertyDescriptionBuilder.primaryFilter)
            .filter(HashableClassPropertyDescriptionBuilder.hashableFilter)
        let hasParent = element.extends != nil
        var comparisons: [String] = []
        if parentPrimaryProperties.count > 0 {
            comparisons.append("super.hashValue")
            if primaryProperties.count > 0 {
                comparisons.append(contentsOf: primaryProperties.map(HashableClassPropertyDescriptionBuilder.hashProperty))
            }
        } else if primaryProperties.count > 0 {
            comparisons.append(contentsOf: primaryProperties.map(HashableClassPropertyDescriptionBuilder.hashProperty))
        } else {
            if hasParent {
                comparisons.append("super.hashValue")
            }
            comparisons.append(contentsOf: element.properties
                .filter(HashableClassPropertyDescriptionBuilder.hashableFilter)
                .map(HashableClassPropertyDescriptionBuilder.hashProperty))
        }
        impl.add(line: "return \(comparisons.joined(separator: "\n^ "))")
        return [
            PropertyDescription(name: "hashValue", options: .init(getVisibility: .public, isOverride: hasParent), type: "Int", compute: .init(get: impl))
        ]
    }
}
