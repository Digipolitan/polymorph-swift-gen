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

    public static let `default` = ClassInterfaceDefinitionFileBuilder()

    private init() { }

    func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        guard let project = element.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.default.build(file: element.name, project: project))

        var protocolDescription = ProtocolDescription(name: element.name, options: .init(visibility: .public))
        protocolDescription.implements.append("CustomStringConvertible")

        if let parentUUID = element.extends,
            let object = project.models.findObject(uuid: parentUUID)  {
            protocolDescription.implements.append(object.name)
        }

        try self.protocolBuilders().forEach { try $0.build(element: element, to: &protocolDescription) }

        fileDescription.protocols.append(protocolDescription)

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

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ClassDefinition.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }

    func protocolBuilders() -> [ProtocolDescriptionBuilder] {
        return [
            ProtocolDefaultDescriptionBuilder.default,
            ProtocolObjectMapperDescriptionBuilder.default
        ]
    }

    func globalScopeMethodBuilders() -> [ClassMethodDescriptionBuilder] {
        return [
            ClassEqualsMethodDescriptionBuilder.default,
            ClassNotEqualsMethodDescriptionBuilder.default,
            ClassArrayEqualsMethodDescriptionBuilder.default,
        ]
    }

    func extensionBuilders() -> [ClassExtensionDescriptionBuilder] {
        return [
            ClassCustomStringConvertibleExtensionDescriptionBuilder.default
        ]
    }
}
