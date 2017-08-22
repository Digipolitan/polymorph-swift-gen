//
//  SwiftPlatformGen.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import PolymorphCore
import PolymorphGen
import SwiftCodeWriter
import Foundation

public class SwiftPlatformGen: PlatformGen {

    public override func models(_ models: Models, options: PlatformGen.Options) throws -> [File] {
        guard let project = models.project else {
            return []
        }
        let files: [File] = try models.classes.map { (modelClass) in
            return File(path: "", name: "")
        }
        print("\(files)")
        return files
    }
}
