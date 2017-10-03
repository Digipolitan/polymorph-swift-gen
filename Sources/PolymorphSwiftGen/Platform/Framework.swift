//
//  Framework.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation

public class Framework {

    public let name: String
    public let classes: [String]

    public init(name: String, classes: [String]) {
        self.name = name
        self.classes = classes
    }
}
