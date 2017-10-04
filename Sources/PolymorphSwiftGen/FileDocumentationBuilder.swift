//
//  FileDocumentationBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore

public class FileDocumentationBuilder {

    public static let shared = FileDocumentationBuilder()

    private let createdAt: String

    private init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        self.createdAt = formatter.string(from: Date())
    }

    public func build(file: String, project: String, author: String? = nil) -> String {
        var parts: [String] = []
        parts.append(file + ".swift")
        parts.append(project)
        parts.append("Created by \(author ?? "Polymorph") on \(self.createdAt)")
        return parts.joined(separator: "\n")
    }
}

extension FileDocumentationBuilder {

    public func build(file: String, project: Project) -> String {
        return self.build(file: file, project: project.name, author: project.author)
    }
}
