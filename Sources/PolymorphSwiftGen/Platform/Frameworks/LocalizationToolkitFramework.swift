//
//  LocalizationToolkitFramework.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 14/11/2017.
//


import Foundation

public class LocalizationToolkitFramework: Framework {

    public static let shared = LocalizationToolkitFramework()

    public static let name = "LocalizationToolkit"

    private init() {
        super.init(name: LocalizationToolkitFramework.name, classes: [
            "MultilingualString"
        ])
    }
}

