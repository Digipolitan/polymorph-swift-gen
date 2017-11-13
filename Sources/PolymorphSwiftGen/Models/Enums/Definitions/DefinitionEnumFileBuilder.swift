//
//  DefinitionEnumFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import SwiftCodeWriter

class DefinitionEnumFileBuilder: EnumFileBuilder {

    public static let shared = DefinitionEnumFileBuilder()

    private init() { }

    func build(element: Enum, options: PolymorphGen.Options) throws -> [File] {

        guard let project = element.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.shared.build(file: element.name, project: project))

        var enumDescription = EnumDescription(name: element.name, options: .init(visibility: .public), rawType: self.rawType(element.rawType))

        try self.enumBuilders().forEach { try $0.build(element: element, to: &enumDescription) }

        fileDescription.enums.append(enumDescription)

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: FilePath.definitionsPath(parent: options.path)
            .append(child: element.package.path(camelcase: true))
            .build(), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }

    func enumBuilders() -> [EnumDescriptionBuilder] {
        return [
            DefaultEnumDescriptionBuilder.shared
        ]
    }

    fileprivate func rawType(_ enumRawType: Enum.RawType) -> String? {
        if enumRawType == .int {
            return "Int"
        } else if enumRawType == .string {
            return "String"
        }
        return nil
    }
}
