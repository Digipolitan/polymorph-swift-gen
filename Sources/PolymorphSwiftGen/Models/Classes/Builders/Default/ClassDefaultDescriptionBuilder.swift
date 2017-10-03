//
//  ClassDefaultDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

struct ClassDefaultDescriptionBuilder: ClassDescriptionBuilder {

    public static let `default` = ClassDefaultDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ClassDescription) throws {
        description.properties.append(contentsOf: try ClassDefaultPropertyDescriptionBuilder.default.build(element: element))
        if let initializer = try ClassDefaultInitializerBuilder.default.build(element: element) {
            description.initializers.append(initializer)
        }
    }
}
