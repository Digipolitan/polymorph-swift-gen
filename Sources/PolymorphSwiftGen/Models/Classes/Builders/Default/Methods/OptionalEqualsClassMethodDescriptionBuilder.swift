//
//  OptionalEqualsClassMethodDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 14/11/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class OptionalEqualsClassMethodDescriptionBuilder: ClassMethodDescriptionBuilder {

    public static let shared = OptionalEqualsClassMethodDescriptionBuilder()

    private init() { }

    func build(element: Class) throws -> MethodDescription? {
        return MethodDescription(name: "== ", code: CodeBuilder.from(code: "return lhs == nil ? (rhs == nil ? true : false) : (rhs == nil ? false : lhs! == rhs!)"), options: .init(visibility: .public), arguments: ["lhs: \(element.name)?", "rhs: \(element.name)?"], returnType: "Bool")
    }
}

