//
//  ProtocolDefaultDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

struct ProtocolDefaultDescriptionBuilder: ProtocolDescriptionBuilder {

    func build(element: Class, to description: inout ProtocolDescription) throws {
        description.properties.append(contentsOf: try ClassDefaultPropertyDescriptionBuilder().build(element: element))
    }
}

