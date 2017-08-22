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
        let modelClassDependencyModuleFileBuilder = ModelClassDependencyModuleFileBuilder()
        try models.classes.forEach {
            files.append(contentsOf: try ModelClassFileBuilderManager.default.build(element: $0, options: options))
            modelClassDependencyModuleFileBuilder.bind($0.name, to: "\($0.name)Model")
        }
        files.append(try modelClassDependencyModuleFileBuilder.build(models: models, options: options))
        return files
    }
}
