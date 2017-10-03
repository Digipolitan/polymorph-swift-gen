//
//  UIKitFramework.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 18/08/2017.
//

import Foundation

public class UIKitFramework: Framework {

    public static let `default` = UIKitFramework()

    public static let name = "UIKit"

    private init() {
        super.init(name: UIKitFramework.name, classes: [
            "UIView"
        ])
    }
}
