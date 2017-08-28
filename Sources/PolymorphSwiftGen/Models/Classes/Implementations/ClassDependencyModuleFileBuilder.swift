//
//  ClassDependencyModuleFileBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 22/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen
import CodeWriter
import SwiftCodeWriter

class ClassDependencyModuleFileBuilder {

    private var dependencies: [String: String]

    public init() {
        self.dependencies = [:]
    }

    public func bind(_ type: String, to target: String) {
        self.dependencies[type] = target
    }

    public func build(models: Models, options: PlatformGen.Options) throws -> File {
        guard let project = models.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        var fileDescription = FileDescription(documentation: FileDocumentationBuilder.default.build(file: "ModelsModule", project: project))

        var classDescription = ClassDescription(name: "ModelsModule", options: .init(visibility: .public), parent: "Module", modules: ["DGDependencyInjector"])

        let code = CodeBuilder()
        code.add(line: "super.init()")
        self.dependencies.forEach {
            code.add(line: "self.bind(\($0.key).self).to(\($0.value).self)")
        }
        classDescription.initializers.append(InitializerDescription(code: code, options: .init(visibility: .public, isOverride: true)))
        fileDescription.classes.append(classDescription)

        let fileStr = FileWriter.default.write(description: fileDescription)
        return File(path: ClassImplementation.absolutePath(parent: options.path) , name: "ModelsModule.swift", data: fileStr.data(using: .utf8))
    }
}
