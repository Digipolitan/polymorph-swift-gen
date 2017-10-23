//
//  SwiftClassFileBuilderManager.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 21/08/2017.
//

import Foundation
import PolymorphCore
import PolymorphGen

class SwiftClassFileBuilderManager: ClassFileBuilderArray {

    public static let shared = SwiftClassFileBuilderManager()

    private init() {
        super.init(children: [
            DefinitionClassFileBuilder.shared,
            ImplementationClassFileBuilder.shared
        ])
     }
}
