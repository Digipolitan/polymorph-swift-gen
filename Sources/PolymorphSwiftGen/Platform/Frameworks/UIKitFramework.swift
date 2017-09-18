//
//  UIKitFramework.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation

public class UIKitFramework: Framework {

    public static let `default` = UIKitFramework()

    public init() {
        super.init(name: "UIKit", classes: [
            "UIView"
        ])
    }
}
