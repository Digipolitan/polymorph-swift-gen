//
//  ClassInitializerRegistry.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

protocol ClassInitializerRegistry {
    var builders: [ClassInitializerDescriptionBuilder] { get }
}

extension ClassInitializerRegistry {

    public func build(element: Class, to description: inout ClassDescription) throws {
        try self.builders.forEach { (builder) in
            if let initializer = try builder.build(element: element) {
                description.initializers.append(initializer)
            }
        }
    }
}
