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

    public func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter.string(from: Date())
    }

    public func fileDocumentation(project: Project, modelClass: Class) -> String {
        var parts: [String] = []
        parts.append(modelClass.name + ".swift")
        parts.append(project.name)
        let author = project.author ?? "Polymorph"
        parts.append("Created by \(author) on \(self.formattedDate())")
        return parts.joined(separator: "\n")
    }

    public override func models(_ models: Models, options: PlatformGen.Options) throws -> [File] {
        guard let project = models.project else {
            return []
        }
        let files: [File] = models.classes.map {
            var fileDescription = FileDescription(documentation: self.fileDocumentation(project: project, modelClass: $0))
            var classDescription = ClassDescription(name: $0.name, options: .init(visibility: .public))

            classDescription.properties.append(contentsOf: $0.properties.map({ (property) in
                var type = models.findObject(uuid: property.type)?.name ?? "Any"
                if !property.isNonnull {
                    type += "?"
                }
                return PropertyDescription(name: property.name, options: .init(getVisibility: .public), type: type, documentation: property.documentation)
            }))
            fileDescription.classes.append(classDescription)
            let fileStr = FileWriter.default.write(description: fileDescription)
            return File(path: options.path, name: "\($0.name).swfit", data: fileStr.data(using: .utf8))
        }
        print("\(files)")
        return files
    }
}
