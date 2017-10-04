//
//  DefaultClassDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class DefaultClassDescriptionBuilder: ClassDescriptionBuilder {

    public static let shared = DefaultClassDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ClassDescription) throws {
        description.properties.append(contentsOf: try DefaultClassPropertyDescriptionBuilder.shared.build(element: element))
        if let initializer = try DefaultClassInitializerDescriptionBuilder.shared.build(element: element) {
            description.initializers.append(initializer)
        }
    }
}
