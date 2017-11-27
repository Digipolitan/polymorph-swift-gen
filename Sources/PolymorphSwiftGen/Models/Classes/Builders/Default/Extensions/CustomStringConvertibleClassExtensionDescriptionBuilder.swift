//
//  CustomStringConvertibleClassExtensionDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class CustomStringConvertibleClassExtensionDescriptionBuilder: ClassExtensionDescriptionBuilder {

    public static let shared = CustomStringConvertibleClassExtensionDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> ExtensionDescription? {
        guard element.extends == nil else {
            return nil
        }
        var extensionDescription = ExtensionDescription(target: element.name, options: .init(visibility: .public))
        extensionDescription.properties.append(PropertyDescription(name: "description",
                                                                   options: .init(getVisibility: .public),
                                                                   modules: ["ObjectMapper"],
                                                                   type: "String",
                                                                   compute: .init(get: CodeBuilder().add(line: "return self.toJSONString(prettyPrint: true) ?? \"{}\""))))
        return extensionDescription
    }
}
