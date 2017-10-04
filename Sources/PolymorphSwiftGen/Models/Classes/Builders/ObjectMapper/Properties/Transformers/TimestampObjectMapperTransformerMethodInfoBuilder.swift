//
//  TimestampObjectMapperTransformerMethodInfoBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class TimestampObjectMapperTransformerMethodInfoBuilder: ObjectMapperTransformerMethodInfoBuilder {

    func build(property: Property) throws -> ObjectMapperTransformerMethodInfo {
        return ObjectMapperTransformerMethodInfo(type: "DateTransform", code: CodeBuilder.from(code: "DateTransform()"))
    }
}
