//
//  EnumDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

protocol EnumDescriptionBuilder {
    func build(element: Enum, to description: inout EnumDescription) throws
}
