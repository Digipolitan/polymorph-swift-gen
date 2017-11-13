//
//  DefaultProtocolDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

class DefaultProtocolDescriptionBuilder: ProtocolDescriptionBuilder {

    public static let shared = DefaultProtocolDescriptionBuilder()

    private init() { }

    func build(element: Class, to description: inout ProtocolDescription) throws {
        description.properties.append(contentsOf: try DefaultClassPropertyDescriptionBuilder.shared.build(element: element))
    }
}
