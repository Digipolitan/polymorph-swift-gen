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
            let parentObject = project.models.findObject(uuid: parentUUID)  {
            protocolDescription.implements.append(parentObject.name)
        } else {
            protocolDescription.implements.append("BaseMappable")
            protocolDescription.modules.append("ObjectMapper")
        }

        protocolDescription.properties.append(contentsOf: element.properties.map({ (property) in
            var type = project.models.findObject(uuid: property.type)?.name ?? "Any"
            if !property.isNonnull {
                type += "?"
            }
            return PropertyDescription(name: property.name, type: type, documentation: property.documentation)
        }))

        fileDescription.protocols.append(protocolDescription)

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ClassDefinition.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }
}
