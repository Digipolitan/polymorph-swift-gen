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

    public override func models(_ models: Models, options: PlatformGen.Options) throws -> [File] {
        var files: [File] = []
        let classDependencyModuleFileBuilder = ClassDependencyModuleFileBuilder()
        try models.classes.forEach {
            files.append(contentsOf: try ClassFileBuilderManager.default.build(element: $0, options: options))
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
