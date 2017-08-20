//
//  DefaultInitializerBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class DefaultInitializerBuilder: DescriptionBuilder<Class, InitializerDescription> {

    public override func build(element: Class) throws -> InitializerDescription? {
        guard let project = element.project else {
            return nil
        }
        var arguments: [String] = []
        let impl = CodeBuilder()

        let parentProperties = element.parentProperties()
        if parentProperties.count > 0 {
            var superArguments: [String] = []
            for property in parentProperties {
                if property.isNonnull {
                    guard let type = project.models.findObject(uuid: property.type) else {
                        return nil
                    }
                    arguments.append("\(property.name): \(type.name)")
                    superArguments.append("\(property.name): \(property.name)")
                }
            }
            impl.add(line: "super.init(\(superArguments.joined(separator: ", ")))")
        }
        for property in element.properties {
            if property.isNonnull {
                guard let type = project.models.findObject(uuid: property.type) else {
                    return nil
                }
                arguments.append("\(property.name): \(type.name)")
                impl.add(line: "self.\(property.name) = \(property.name)")
            }
        }
        return InitializerDescription(code: impl, options: .init(visibility: .public), arguments: arguments)
    }
}
