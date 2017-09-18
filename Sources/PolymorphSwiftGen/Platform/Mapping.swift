//
//  Mapping.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation
import PolymorphCore

class Mapping {

    public static let `shared` = Mapping()

    public private(set) var modules: [String: String]

    private init() {
        self.modules = [:]
        self.register(framework: FoundationFramework.default)
        self.register(framework: UIKitFramework.default)
    }

    public func platformType(with type: String, genericTypes: [String]? = nil) -> String {
        if let gt = genericTypes, gt.count > 0 {
            let translationGenericType = gt.map { self.platformType(with: $0) }
            if type == Native.DataType.array.rawValue {
                return "[\(translationGenericType[0])]"
            } else if type == Native.DataType.map.rawValue {
                let mapTranslation = "[\(translationGenericType[0]): "
                if translationGenericType.count > 1 {
                    return mapTranslation + "\(translationGenericType[1])]"
                }
                return mapTranslation + "Any]"
            }
            return "\(type)<\(translationGenericType.joined(separator: ", "))>"
        }
        if type == Native.DataType.array.rawValue {
            return "[Any]"
        } else if type == Native.DataType.map.rawValue {
            return "[Hashable: Any]"
        }
        return type
    }

    public func register(framework: Framework) {
        framework.classes.forEach { modules[$0] = framework.name }
    }
}

extension Mapping {

    public static func model(with property: Property) throws -> Object {
        guard let project = property.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        return try Mapping.model(with: property.type, project: project)
    }

    public static func model(with uuid: UUID, project: Project) throws -> Object {
        guard let type = project.models.findObject(uuid: uuid) else {
            throw PolymorphSwiftGenError.malformatedProject
        }
        return type
    }

    public func platformType(with property: Property) throws -> String {
        guard let project = property.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        let type = try Mapping.model(with: property)
        let gts = try property.genericTypes?.map { return try Mapping.model(with: $0, project: project).name }
        return self.platformType(with: type.name, genericTypes: gts)
    }

    public func modules(with property: Property) throws -> [String] {
        guard let project = property.project else {
            throw PolymorphSwiftGenError.projectCannotBeNil
        }
        let type = try Mapping.model(with: property)
        var modules: [String] = []
        if let module = self.modules[type.name] {
            modules.append(module)
        }
        try property.genericTypes?.forEach {
            let type = try Mapping.model(with: $0, project: project)
            if let module = self.modules[type.name] {
                modules.append(module)
            }
        }
        return modules
    }
}
