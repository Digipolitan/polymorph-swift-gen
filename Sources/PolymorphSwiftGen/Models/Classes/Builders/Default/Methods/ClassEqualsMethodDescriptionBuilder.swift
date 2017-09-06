//
//  ClassEqualsMethodDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

struct ClassEqualsMethodDescriptionBuilder: ClassMethodDescriptionBuilder {

    public static let `default` = ClassEqualsMethodDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> MethodDescription? {
        let allProperties = element.properties + element.parentProperties()
        let primaryProperties = allProperties.filter { $0.isPrimary }
        let impl = CodeBuilder()
        let comparisons = primaryProperties.count > 0 ? primaryProperties.map { "lhs.\($0.name) == rhs.\($0.name)" } : allProperties.map { "lhs.\($0.name) == rhs.\($0.name)" }
        impl.add(line: "return \(comparisons.joined(separator: "\n&& "))")
        return MethodDescription(name: "==", code: impl, options: .init(visibility: .public), arguments: ["lhs: \(element.name)", "rhs: \(element.name)"], returnType: "Bool")
    }
}
