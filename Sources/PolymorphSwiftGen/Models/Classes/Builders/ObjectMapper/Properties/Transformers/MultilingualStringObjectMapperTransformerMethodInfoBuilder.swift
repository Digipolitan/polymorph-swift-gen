//
//  MultilingualStringObjectMapperTransformerMethodInfoBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 14/11/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class MultilingualStringObjectMapperTransformerMethodInfoBuilder: ObjectMapperTransformerMethodInfoBuilder {

    func build(property: Property) throws -> ObjectMapperTransformerMethodInfo {
        return ObjectMapperTransformerMethodInfo(type: "MultilingualStringTransform",
                                                 code: CodeBuilder.from(code: "return MultilingualStringTransform.shared"),
                                                 modules: ["LocalizationToolkitObjectMapper"])
    }
}
