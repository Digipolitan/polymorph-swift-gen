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
        classDescription.implements.append("CustomStringConvertible")

        try self.classBuilders().forEach { try $0.build(element: element, to: &classDescription) }

        try self.extensionBuilders().forEach {
            if let ext = try $0.build(element: element) {
                fileDescription.extensions.append(ext)
            }
        }

        try self.globalScopeMethodBuilders().forEach {
            if let method = try $0.build(element: element) {
                fileDescription.methods.append(method)
            }
        }
        
        fileDescription.classes.append(classDescription)

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ClassDefinition.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }

    func classBuilders() -> [ClassDescriptionBuilder] {
        return [
            ClassDefaultDescriptionBuilder(),
            ClassObjectMapperDescriptionBuilder(),
            ClassHashableDescriptionBuilder()
        ]
    }

    func globalScopeMethodBuilders() -> [ClassMethodDescriptionBuilder] {
        return [
            ClassEqualsMethodDescriptionBuilder(),
            ClassNotEqualsMethodDescriptionBuilder(),
            ClassArrayEqualsMethodDescriptionBuilder(),
        ]
    }
    
    func extensionBuilders() -> [ClassExtensionDescriptionBuilder] {
        return [
            ClassCustomStringConvertibleExtensionDescriptionBuilder()
        ]
    }
}
