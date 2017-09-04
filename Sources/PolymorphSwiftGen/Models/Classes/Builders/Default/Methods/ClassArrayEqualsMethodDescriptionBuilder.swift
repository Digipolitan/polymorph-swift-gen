//
//  ClassArrayEqualsMethodDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

struct ClassArrayEqualsMethodDescriptionBuilder: ClassMethodDescriptionBuilder {

    func build(element: Class) throws -> MethodDescription? {
        let impl = CodeBuilder()
        impl.add(line: "let count = lhs.count")
        impl.add(line: "if count == rhs.count {").rightTab()
        impl.add(line: "for var i in 0...<count {").rightTab()
        impl.add(line: "if lhs[i] != rhs[i] {").rightTab()
        impl.add(line: "return false").leftTab()
        impl.add(line: "}").leftTab()
        impl.add(line: "}")
        impl.add(line: "return true").leftTab()
        impl.add(line: "}")
        impl.add(line: "return false")
        return MethodDescription(name: "==", code: impl, options: .init(visibility: .public), arguments: ["lhs: [\(element.name)]", "rhs: [\(element.name)]"], returnType: "Bool")
    }
}
