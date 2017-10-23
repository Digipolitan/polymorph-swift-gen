//
//  FilePath.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation
import PolymorphGen

public class FilePath {

    private init() { }

    public class Builder {

        private var path: String
        private var children: [String]

        fileprivate init(path: String) {
            self.path = path
            self.children = []
        }

        public func append(child: String) -> Builder {
            self.children.append(child)
            return self
        }

        public func build() -> String {
            return Dir.cd(parent: self.path, children: self.children)
        }
    }

    public static let implementationsDirectory = "Implementations"
    public static let definitionsDirectory = "Definitions"

    public static func implementationsPath(parent: String) -> Builder {
        return Builder(path: parent).append(child: FilePath.implementationsDirectory)
    }

    public static func definitionsPath(parent: String) -> Builder {
        return Builder(path: parent).append(child: FilePath.definitionsDirectory)
    }
}
