//
//  SwiftPlatformGen.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import PolymorphCore
import PolymorphGen
import Foundation

public class SwiftPlatformGen: PlatformGen {

    public static let shared: PlatformGen = SwiftPlatformGen()

    public static var name: String {
        return "Swift"
    }

    public func generate(_ project: Project, options: PolymorphGen.Options) throws -> [File] {
        var files: [File] = []
        files.append(contentsOf: try self.models(project.models, options: options))
        return files
    }

    public func models(_ models: Models, options: PolymorphGen.Options) throws -> [File] {
        var files: [File] = []
        let classDependencyModuleFileBuilder = ClassDependencyModuleFileBuilder()
        try models.classes.values.forEach {
            files.append(contentsOf: try SwiftClassFileBuilderManager.default.build(element: $0, options: options))
            if $0.injectable || $0.serializable {
                classDependencyModuleFileBuilder.bind($0.name, to: "\($0.name)Model")
            }
        }
        if classDependencyModuleFileBuilder.dependencies.count > 0 {
            files.append(try classDependencyModuleFileBuilder.build(models: models, options: options))
        }
        return files
    }
}
