//
//  SwiftEnumFileBuilderManager.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 23/10/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen

class SwiftEnumFileBuilderManager: EnumFileBuilderArray {

    public static let shared = SwiftEnumFileBuilderManager()

    private init() {
        super.init(children: [
            DefinitionEnumFileBuilder.shared
        ])
    }
}
