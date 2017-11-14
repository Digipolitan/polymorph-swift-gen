//
//  ProtocolObjectMapperDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class ObjectMapperProtocolDescriptionBuilder: ProtocolDescriptionBuilder {

    public static let shared = ObjectMapperProtocolDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ProtocolDescription) throws {
        if element.extends == nil {
            description.implements.append("BaseMappable")
            description.modules.append("ObjectMapper")
        }
    }
}
