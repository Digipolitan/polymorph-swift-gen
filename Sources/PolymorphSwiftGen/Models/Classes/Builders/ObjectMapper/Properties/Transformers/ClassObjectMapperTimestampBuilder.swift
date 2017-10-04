//
//  ClassObjectMapperTimestampBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 04/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class ClassObjectMapperTimestampBuilder: ClassObjectMapperTransformerBuilder {

    func build(property: Property) throws -> ObjectMapperTransformMethod {
        return ObjectMapperTransformMethod(type: "DateTransform", code: CodeBuilder.from(code: "DateTransform()"))
    }
}
