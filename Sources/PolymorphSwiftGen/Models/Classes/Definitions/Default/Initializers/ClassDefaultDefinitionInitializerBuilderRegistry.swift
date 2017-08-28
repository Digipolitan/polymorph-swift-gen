//
//  ClassDefaultDefinitionInitializerBuilderRegistry.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class ClassDefaultDefinitionInitializerBuilderRegistry: ClassInitializerRegistry {

    public private(set) var builders: [ClassInitializerDescriptionBuilder] = []

    public static let `default` = ClassDefaultDefinitionInitializerBuilderRegistry()

    private init() {
        self.builders.append(ClassDefaultInitializerBuilder())
        self.builders.append(ClassMappableInitializerBuilder())
    }
}

