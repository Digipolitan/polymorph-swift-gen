//
//  NotEqualsClassMethodDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class NotEqualsClassMethodDescriptionBuilder: ClassMethodDescriptionBuilder {

    public static let shared = NotEqualsClassMethodDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> MethodDescription? {
        let impl = CodeBuilder()
        impl.add(line: "return !(lhs == rhs)")
        return MethodDescription(name: "!= ", code: impl, options: .init(visibility: .public), arguments: ["lhs: \(element.name)", "rhs: \(element.name)"], returnType: "Bool")
    }
}
