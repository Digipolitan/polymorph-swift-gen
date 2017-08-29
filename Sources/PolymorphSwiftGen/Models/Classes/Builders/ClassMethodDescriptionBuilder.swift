//
//  ClassMethodDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

protocol ClassMethodDescriptionBuilder {
    func build(element: Class) throws -> MethodDescription?
}
