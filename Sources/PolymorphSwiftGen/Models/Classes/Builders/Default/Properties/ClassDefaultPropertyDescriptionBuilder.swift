//
//  ClassDefaultPropertyDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
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
            return PropertyDescription(name: property.name, options: .init(getVisibility: .public), modules: try Mapping.shared.modules(with: property), type: type, documentation: property.documentation)
        })
    }
}
