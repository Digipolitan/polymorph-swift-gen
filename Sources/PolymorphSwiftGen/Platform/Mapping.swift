//
//  Mapping.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation
import PolymorphCore

public class Mapping {

    public static let `shared` = Mapping()

    public var translations: [String: String]
    public var modules: [String: String]

    private init() {
        self.translations = [:]
        self.modules = [:]
    }

    public func platform(object: Object) -> String {
        return self.translations[object.name] ?? object.name
    }

    public func register(framework: Framework) {
        framework.classes.forEach { modules[$0] = framework.name }
    }

}
