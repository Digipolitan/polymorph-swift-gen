//
//  FoundationFramework.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation

public class FoundationFramework: Framework {

    public static let shared = FoundationFramework()

    public static let name = "Foundation"
    
    private init() {
        super.init(name: FoundationFramework.name, classes: [
            "Date",
            "NSString"
        ])
    }
}
