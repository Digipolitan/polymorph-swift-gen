//
//  DateObjectMapperTransformerMethodInfoBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 05/10/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class DateObjectMapperTransformerMethodInfoBuilder: ObjectMapperTransformerMethodInfoBuilder {

    func build(property: Property) throws -> ObjectMapperTransformerMethodInfo {

        let options = DateObjectMapperTransformerMethodInfoBuilder.mergeOptions(of: property)
        guard let dateFormat = options["format"]?.value else {
            throw PolymorphSwiftGenError.malformatedProject
        }

        let code = CodeBuilder()
        code.add(line: "let df = DateFormatter()")
        code.add(line: "df.dateFormat = \"\(dateFormat)\"")
        code.add(line: "return DateFormatterTransform(dateFormatter: df)")
        return ObjectMapperTransformerMethodInfo(type: "DateFormatterTransform", code: code)
    }
}
