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

public struct DefaultInitializerBuilder {

    public func build(modelClass: Class) throws -> InitializerDescription? {
        guard let project = modelClass.project else {
            return nil
        }
        var arguments: [String] = []
        let impl = CodeBuilder()
        for property in modelClass.properties {
            if property.isNonnull {
                guard let type = project.models.findObject(uuid: property.type) else {
                    return nil
                }
                arguments.append("\(property.name): \(type)")
                impl.add(line: "self.\(property.name) = \(property.name)")
            }
        }
        return InitializerDescription(code: impl, options: .init(visibility: .public), arguments: arguments)
    }

}
