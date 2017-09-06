//
//  ProtocolObjectMapperDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

struct ProtocolObjectMapperDescriptionBuilder: ProtocolDescriptionBuilder {

    public static let `default` = ProtocolObjectMapperDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ProtocolDescription) throws {
        if element.extends == nil {
            description.implements.append("BaseMappable")
            description.modules.append("ObjectMapper")
        }
    }
}

