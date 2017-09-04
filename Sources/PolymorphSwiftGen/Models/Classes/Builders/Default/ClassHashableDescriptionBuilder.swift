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

    func build(element: Class, to description: inout ClassDescription) throws {

        if element.extends == nil {
            description.implements.append("Hashable")
        }
        let properties = try ClassHashablePropertyBuilder().build(element: element)
        description.properties.append(contentsOf: properties)
    }
}

fileprivate struct ClassHashablePropertyBuilder: ClassPropertyDescriptionBuilder {

    func build(element: Class) throws -> [PropertyDescription] {
        let impl = CodeBuilder()
        let primaryProperties = element.properties.filter { $0.isPrimary }
        let parentPrimaryProperties = element.parentProperties().filter { $0.isPrimary }
        var comparisons: [String] = []
        if parentPrimaryProperties.count > 0 {
            comparisons.append("super.hashValue")
            if primaryProperties.count > 0 {
                comparisons.append(contentsOf: primaryProperties.map { "self.\($0.name)" })
            }
        } else if primaryProperties.count > 0 {
            comparisons.append(contentsOf: primaryProperties.map { "self.\($0.name)" })
        } else {
            comparisons.append("super.hashValue")
            comparisons.append(contentsOf: element.properties.map { "self.\($0.name)" })
        }
        impl.add(line: comparisons.joined(separator: "\n^ "))
        return [
            PropertyDescription(name: "hashValue", options: .init(getVisibility: .public, isOverride: element.extends != nil), type: "Int", compute: .init(get: impl))
        ]
    }
}
