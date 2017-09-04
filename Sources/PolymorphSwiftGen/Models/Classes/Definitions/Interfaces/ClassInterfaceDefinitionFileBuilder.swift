//
//  ClassInterfaceDefinitionFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import SwiftCodeWriter

struct ClassInterfaceDefinitionFileBuilder: ClassFileBuilder {

    func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        guard let project = element.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.default.build(file: element.name, project: project))

        var protocolDescription = ProtocolDescription(name: element.name, options: .init(visibility: .public))

        if let parentUUID = element.extends,
            let object = project.models.findObject(uuid: parentUUID)  {
            protocolDescription.implements.append(object.name)
        }

        try self.builders().forEach { try $0.build(element: element, to: &protocolDescription) }

        fileDescription.protocols.append(protocolDescription)

        if let customStringConvertibleExtensionDescription = try ClassCustomStringConvertibleExtensionDescriptionBuilder().build(element: element) {
            fileDescription.extensions.append(customStringConvertibleExtensionDescription)
        }

        if let equalsMethodDescription = try ClassEqualsMethodDescriptionBuilder().build(element: element) {
            fileDescription.methods.append(equalsMethodDescription)
        }
        if let notEqualsMethodDescription = try ClassNotEqualsMethodDescriptionBuilder().build(element: element) {
            fileDescription.methods.append(notEqualsMethodDescription)
        }

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ClassDefinition.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }

    func builders() -> [ProtocolDescriptionBuilder] {
        return [
            ProtocolDefaultDescriptionBuilder(),
            ProtocolObjectMapperDescriptionBuilder()
        ]
    }
}
