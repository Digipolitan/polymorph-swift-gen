//
//  ClassInitializerBuilderRegistry.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 20/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class ClassInitializerBuilderRegistry {

    public private(set) var builders: [ClassInitializerDescriptionBuilder] = []

    public static let `default` = ClassInitializerBuilderRegistry()

    private init() {
        self.builders.append(DefaultInitializerBuilder())
    }
}
