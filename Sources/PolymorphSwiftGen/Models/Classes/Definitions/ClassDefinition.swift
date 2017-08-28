//
//  ClassDefinition.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 22/08/2017.
//

import Foundation

public enum ClassDefinition {
    public static let path: String = "Definitions"

    public static func absolutePath(parent: String, child: String? = nil) -> String {
        var cur = "\(parent)/\(path)"
        if let unwrap = child {
            cur += "/\(unwrap)"
        }
        return cur
    }
}
