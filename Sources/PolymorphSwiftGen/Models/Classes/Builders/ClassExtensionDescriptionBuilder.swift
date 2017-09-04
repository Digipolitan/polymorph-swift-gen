//
//  ClassExtensionDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/09/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

protocol ClassExtensionDescriptionBuilder {
    func build(element: Class) throws -> ExtensionDescription?
}
