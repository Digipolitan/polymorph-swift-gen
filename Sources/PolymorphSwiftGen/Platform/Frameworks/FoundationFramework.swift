//
//  FoundationFramework.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation

public class FoundationFramework: Framework {

    public init() {
        super.init(name: "Foundation", classes: [
            "Date",
            "NSString"
        ])
    }
}
