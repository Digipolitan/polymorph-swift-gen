//
//  SwiftPropertyDescription.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation
import PolymorphGen

struct SwiftPropertyDescription {

    struct Options {
        public let visibility: SwiftVisibility
        public let isLazy: Bool
        public let isStatic: Bool

        public init(visibility: SwiftVisibility = .public, isLazy: Bool = false, isStatic: Bool = false) {
            self.visibility = visibility
            self.isLazy = isLazy
            self.isStatic = isStatic
        }
    }

    struct ComputeDescription {
        public let get: CodeBuilder
        public let set: CodeBuilder?

        public init(get: CodeBuilder, set: CodeBuilder? = nil) {
            self.get = get
            self.set = set
        }
    }

    public let name: String
    public let options: Options
    public let module: String?
    public let value: String?
    public let compute: ComputeDescription?

    public init(name: String, options: Options = Options(), value: String? = nil, module: String? = nil, compute: ComputeDescription? = nil) {
        self.name = name
        self.options = options
        self.module = module
        self.value = value
        self.compute = compute
    }
}
