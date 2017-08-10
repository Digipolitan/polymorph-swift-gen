//
//  SwiftClassDescription.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation

struct SwiftClassDescription {

    struct Options {
        public let visibility: SwiftVisibility
        public let isReferenceType: Bool

        public init(visiblity: SwiftVisibility = .public, isReferenceType: Bool = true) {
            self.visibility = visiblity
            self.isReferenceType = isReferenceType
        }
    }

    public let name: String
    public let options: Options
    public let parent: String?
    public var implements: [String]
    public var modules: [String]
    public var initializers: [SwiftInitializerDescription]
    public var methods: [SwiftMethodDescription]
    public var properties: [SwiftPropertyDescription]
    public var nestedClasses: [SwiftClassDescription]
    public let documentation: String?

    public init(name: String, options: Options = Options(), parent: String? = nil, modules: [String] = [], documentation: String? = nil) {
        self.name = name
        self.options = options
        self.parent = parent
        self.modules = modules
        self.documentation = documentation
        self.implements = []
        self.initializers = []
        self.methods = []
        self.properties = []
        self.nestedClasses = []
    }

    public func moduleDependencies() -> [String] {
        var modules = Set<String>()
        modules.formUnion(self.modules)
        for nested in self.nestedClasses {
            modules.formUnion(nested.moduleDependencies())
        }
        for initializer in self.initializers {
            modules.formUnion(initializer.modules)
        }
        for method in self.methods {
            modules.formUnion(method.modules)
        }
        for property in self.properties {
            if let module = property.module {
                modules.insert(module)
            }
        }
        return Array(modules)
    }
}
