//
//  ClassFrameworkDescriptionBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 28/08/2017.
//

import Foundation
import PolymorphCore
import SwiftCodeWriter

protocol ClassDescriptionBuilder {
    func build(element: Class, to description: inout ClassDescription) throws
}
