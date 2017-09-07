//
//  ClassHashableDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

struct ClassHashableDescriptionBuilder: ClassDescriptionBuilder {

    public static let `default` = ClassHashableDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ClassDescription) throws {

        if element.extends == nil {
            description.implements.append("Hashable")
        }
        let properties = try ClassHashablePropertyBuilder.default.build(element: element)
        description.properties.append(contentsOf: properties)
    }
}

fileprivate struct ClassHashablePropertyBuilder: ClassPropertyDescriptionBuilder {

    fileprivate static let `default` = ClassHashablePropertyBuilder()

    private init() { }

    func build(element: Class) throws -> [PropertyDescription] {
        let impl = CodeBuilder()
        let primaryProperties = element.properties.filter { $0.isPrimary }
        let parentPrimaryProperties = element.parentProperties().filter { $0.isPrimary }
        let hasParent = element.extends != nil
        var comparisons: [String] = []
        let propertyToHash = { (p: Property) -> String in
            if p.isNonnull {
                return "self.\(p.name).hashValue"
            }
            return "(self.\(p.name)?.hashValue ?? 0)"
        }
        if parentPrimaryProperties.count > 0 {
            comparisons.append("super.hashValue")
            if primaryProperties.count > 0 {
                comparisons.append(contentsOf: primaryProperties.map(propertyToHash))
            }
        } else if primaryProperties.count > 0 {
            comparisons.append(contentsOf: primaryProperties.map(propertyToHash))
        } else {
            if hasParent {
                comparisons.append("super.hashValue")
            }
            comparisons.append(contentsOf: element.properties.map(propertyToHash))
        }
        impl.add(line: "return \(comparisons.joined(separator: "\n^ "))")
        return [
            PropertyDescription(name: "hashValue", options: .init(getVisibility: .public, isOverride: hasParent), type: "Int", compute: .init(get: impl))
        ]
    }
}
