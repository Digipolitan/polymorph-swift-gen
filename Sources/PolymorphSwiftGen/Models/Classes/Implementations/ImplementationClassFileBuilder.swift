//
//  ImplementationClassFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import SwiftCodeWriter

class ImplementationClassFileBuilder: ClassFileBuilder {

    public static let shared = ImplementationClassFileBuilder()

    private init() { }

    func build(element: Class, options: PolymorphGen.Options) throws -> [File] {
        guard let project = element.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        guard element.injectable || element.serializable else {
            return []
        }

        let className = "\(element.name)Model"

        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.shared.build(file: className, project: project))

        var parent: String? = nil
        if let parentUUID = element.extends,
            let parentObject = project.models.findObject(uuid: parentUUID)  {
            parent = "\(parentObject.name)Model"
        }
        var classDescription = ClassDescription(name: className, options: .init(), parent: parent)
        classDescription.implements.append(element.name)

        try self.builders().forEach { try $0.build(element: element, to: &classDescription) }
       
        fileDescription.classes.append(classDescription)
        let fileStr = FileWriter.default.write(description: fileDescription)

        return [File(path: FilePath.implementationsPath(parent: options.path)
            .append(child: "Models")
            .append(child: element.package.path(camelcase: true))
            .build(), name: "\(className).swift", data: fileStr.data(using: .utf8))]
    }

    func builders() -> [ClassDescriptionBuilder] {
        return [
            DefaultClassDescriptionBuilder.shared,
            ObjectMapperClassDescriptionBuilder.shared
        ]
    }
}
