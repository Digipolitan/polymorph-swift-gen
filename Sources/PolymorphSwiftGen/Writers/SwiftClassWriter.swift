//
//  SwiftClassWriter.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import PolymorphGen

class SwiftClassWriter {

    public static let `default` = SwiftClassWriter()

    private init() {}

    public func write(classDescription: SwiftClassDescription, depth: Int = 0) -> String {

        var parts: [String] = []

        if let documentation = classDescription.documentation {
            parts.append(SwiftDocumentationSingleLineWriter.default.write(documentation: documentation, depth: depth, mode: .stars))
        }

        let builder = CodeBuilder(depth: depth)
        builder.add(string: classDescription.options.visibility.rawValue, indent: true)
        if classDescription.options.isReferenceType {
            builder.add(string: " class")
        } else {
            builder.add(string: " struct")
        }
        builder.add(string: " \(classDescription.name)")
        var commaImplementsSeparator = false
        if let parent = classDescription.parent {
            builder.add(string: " : \(parent)")
            commaImplementsSeparator = true
        }
        classDescription.implements.forEach {
            if commaImplementsSeparator {
                builder.add(string: ",")
            } else {
                builder.add(string: " :")
                commaImplementsSeparator = true
            }
            builder.add(string: " \($0)")
        }
        parts.append(builder.build())

        return parts.joined(separator: "\n")
    }
}

