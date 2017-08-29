//
//  ClassDefaultDefinitionFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import SwiftCodeWriter

struct ClassDefaultDefinitionFileBuilder: ClassFileBuilder {

    func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        guard let project = element.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.default.build(file: element.name, project: project))

        var classDescription = ClassDescription(name: element.name, options: .init(visibility: .public))

        try self.builders().forEach { try $0.build(element: element, to: &classDescription) }
        
        fileDescription.classes.append(classDescription)

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ClassDefinition.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }

    func builders() -> [ClassDescriptionBuilder] {
        return [
            ClassDefaultDescriptionBuilder(),
            ClassObjectMapperDescriptionBuilder()
        ]
    }
}
