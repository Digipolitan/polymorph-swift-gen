//
//  ModelClassImplementation.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 22/08/2017.
//

import Foundation

public enum ModelClassImplementation {
    public static let path: String = "Implementations/Models"

    public static func absolutePath(parent: String, child: String? = nil) -> String {
        var cur = "\(parent)/\(path)"
        if let unwrap = child {
            cur += "/\(unwrap)"
        }
        return cur
    }
}
