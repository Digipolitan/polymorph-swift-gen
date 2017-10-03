//
//  ClassImplementation.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 22/08/2017.
//

import Foundation
import PolymorphGen

public enum ClassImplementation {
    public static let path: String = "Implementations/Models"

    public static func absolutePath(parent: String, child: String? = nil) -> String {
        var children = [path]
        if let unwrap = child {
            children.append(unwrap)
        }
        return Dir.cd(parent: parent, children: children)
    }
}
