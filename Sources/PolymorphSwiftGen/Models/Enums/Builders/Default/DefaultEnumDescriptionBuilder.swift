//
//  DefaultEnumDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class DefaultEnumDescriptionBuilder: EnumDescriptionBuilder {

    public static let shared = DefaultEnumDescriptionBuilder()

    private init() { }

    func build(element: Enum, to description: inout EnumDescription) throws {
        description.cases = element.values.map { EnumDescription.Case(name: $0.name, rawValue: self.rawValue(type: element.rawType, caseValue: $0.raw)) }
    }

    fileprivate func rawValue(type: Enum.RawType, caseValue: String) -> String {
        if type == .string {
            return "\"\(caseValue)\""
        }
        return caseValue
    }
}
