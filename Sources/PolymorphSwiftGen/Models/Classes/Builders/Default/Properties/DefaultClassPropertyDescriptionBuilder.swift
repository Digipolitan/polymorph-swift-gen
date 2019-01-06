//
//  DefaultClassPropertyDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class DefaultClassPropertyDescriptionBuilder: ClassPropertyDescriptionBuilder {

    public static let shared = DefaultClassPropertyDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> [PropertyDescription] {
        return try element.properties.map({ (property) in
            var type = try Mapping.shared.platformType(with: property)
            if !property.isNonnull {
                type += "?"
            } else if property.isTransient {
                type += "!"
            } else if let isIgnored = property.mapping?.isIgnored, isIgnored == true {
                type += "!"
            }
            var defaultValue: CodeBuilder?
            if let value = property.defaultValue {
                defaultValue = CodeBuilder.from(code: value)
            }
            return PropertyDescription(name: property.name,
                                       options: .init(getVisibility: .public, isConstant: property.isConst),
                                       modules: try Mapping.shared.modules(with: property),
                                       type: type,
                                       value: defaultValue,
                                       documentation: property.documentation)
        })
    }
}
