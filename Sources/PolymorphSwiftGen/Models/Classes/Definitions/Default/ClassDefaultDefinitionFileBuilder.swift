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

        if element.extends == nil {
            classDescription.implements.append("Mappable")
            classDescription.modules.append("ObjectMapper")
        }

        classDescription.properties.append(contentsOf: element.properties.map({ (property) in
            var type = project.models.findObject(uuid: property.type)?.name ?? "Any"
            if !property.isNonnull {
                type += "?"
            }
            return PropertyDescription(name: property.name, options: .init(getVisibility: .public), type: type, documentation: property.documentation)
        }))

        try ClassDefaultDefinitionInitializerBuilderRegistry.default.build(element: element, to: &classDescription)

        fileDescription.classes.append(classDescription)

        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ClassDefinition.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(element.name).swift", data: fileStr.data(using: .utf8))]
    }
}
