//
//  SwiftFileWriter.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation

class SwiftFileWriter {

    public static let `default` = SwiftFileWriter()

    private init() {}

    public func write(fileDescription: SwiftFileDescription) -> String {

        var parts: [String] = []

        if let documentation = fileDescription.documentation {
            parts.append(SwiftDocumentationSingleLineWriter.default.write(documentation: documentation))
        }

        parts.append(contentsOf: fileDescription.moduleDependencies().map({ "import \($0)" }))

        return parts.joined(separator: "\n")
    }
}
