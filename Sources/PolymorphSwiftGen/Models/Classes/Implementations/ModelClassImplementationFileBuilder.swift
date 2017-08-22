//
//  ModelClassImplementationFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import SwiftCodeWriter

struct ModelClassImplementationFileBuilder: ModelClassFileBuilder {

    func build(element: Class, options: PlatformGen.Options) throws -> [File] {
        guard let project = element.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }

        let className = "\(element.name)Model"

        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.default.build(file: className, project: project))

        var parent: String? = nil
        if let parentUUID = element.extends,
            let parentObject = project.models.findObject(uuid: parentUUID)  {
            parent = "\(parentObject.name)Model"
        }
        var classDescription = ClassDescription(name: className, options: .init(), parent: parent)
        classDescription.implements.append(element.name)

        classDescription.properties.append(contentsOf: element.properties.map({ (property) in
            var type = project.models.findObject(uuid: property.type)?.name ?? "Any"
            if !property.isNonnull {
                type += "?"
            }
            return PropertyDescription(name: property.name, options: .init(getVisibility: .public), type: type, documentation: property.documentation)
        }))

        try ClassInitializerBuilderRegistry.default.builders.forEach { (builder) in
            if let initializer = try builder.build(element: element) {
                classDescription.initializers.append(initializer)
            }
        }

        fileDescription.classes.append(classDescription)
        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: ModelClassImplementation.absolutePath(parent: options.path, child: element.package.path(camelcase: true)), name: "\(className).swift", data: fileStr.data(using: .utf8))]
    }
}
