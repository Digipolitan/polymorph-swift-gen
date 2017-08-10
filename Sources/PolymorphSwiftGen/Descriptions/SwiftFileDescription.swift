//
//  SwiftFileDescription.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation

struct SwiftFileDescription {

    public var classes: [SwiftClassDescription]
    public var protocols: [SwiftProtocolDescription]
    public var extensions: [SwiftExtensionDescription]
    public var methods: [SwiftMethodDescription]
    public var properties: [SwiftPropertyDescription]
    public let documentation: String?

    public init(documentation: String? = nil) {
        self.documentation = documentation
        self.classes = []
        self.protocols = []
        self.extensions = []
        self.methods = []
        self.properties = []
    }

    public func moduleDependencies() -> [String] {
        var modules = Set<String>()
        for c in self.classes {
            modules.formUnion(c.moduleDependencies())
        }
        for p in self.protocols {
            modules.formUnion(p.moduleDependencies())
        }
        for e in self.extensions {
            modules.formUnion(e.moduleDependencies())
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
