//
//  ClassImplementationInitializerBuilderRegistry.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 20/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class ClassImplementationInitializerBuilderRegistry: ClassInitializerRegistry {

    public private(set) var builders: [ClassInitializerDescriptionBuilder] = []

    public static let `default` = ClassImplementationInitializerBuilderRegistry()

    private init() {
        self.builders.append(ClassDefaultInitializerBuilder())
        self.builders.append(ClassMappableInitializerBuilder())
    }
}
