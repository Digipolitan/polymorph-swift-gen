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
        description.cases = element.values.map { EnumDescription.Case(name: $0.name, rawValue: self.rawValue(type: element.rawType, value: $0)) }
    }

    fileprivate func rawValue(type: Enum.RawType, value: Enum.Value) -> String? {
        if type == .string {
            if value.name != value.raw {
                return "\"\(value.raw)\""
            }
            return nil
        }
        return value.raw
    }
}
