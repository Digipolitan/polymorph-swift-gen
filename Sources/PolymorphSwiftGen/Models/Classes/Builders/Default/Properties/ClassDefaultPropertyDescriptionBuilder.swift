//
//  ClassDefaultPropertyDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

struct ClassDefaultPropertyDescriptionBuilder: ClassPropertyDescriptionBuilder {

    public static let `default` = ClassDefaultPropertyDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> [PropertyDescription] {
        return try element.properties.map({ (property) in
            var type = try Mapping.shared.platformType(with: property)
            if !property.isNonnull {
                type += "?"
            }
            var defaultValue: CodeBuilder? = nil
            if let value = property.defaultValue {
                defaultValue = CodeBuilder.from(code: value)
            }
            return PropertyDescription(name: property.name, options: .init(getVisibility: .public, isConstant: property.isConst), modules: try Mapping.shared.modules(with: property), type: type, value: defaultValue, documentation: property.documentation)
        })
    }
}
