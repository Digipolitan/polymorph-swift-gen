//
//  ClassInitializerDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

protocol ClassInitializerDescriptionBuilder {
    func build(element: Class) throws -> InitializerDescription?
}
