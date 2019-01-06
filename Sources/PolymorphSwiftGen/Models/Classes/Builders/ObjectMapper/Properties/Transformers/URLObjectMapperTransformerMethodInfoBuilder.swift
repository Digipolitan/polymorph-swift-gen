//
//  URLObjectMapperTransformerMethodInfoBuilder.swift
//  PolymorphSwiftGen
//
//  Created by Benoit BRIATTE on 14/11/2017.
//

import Foundation
import PolymorphCore
import CodeWriter
import SwiftCodeWriter

class URLObjectMapperTransformerMethodInfoBuilder: ObjectMapperTransformerMethodInfoBuilder {

    func build(property: Property) throws -> ObjectMapperTransformerMethodInfo {

        let options = URLObjectMapperTransformerMethodInfoBuilder.mergeOptions(of: property)
        guard let encode = options["encode"]?.value else {
            throw PolymorphSwiftGenError.malformatedProject
        }

        return ObjectMapperTransformerMethodInfo(type: "URLTransform", code: CodeBuilder.from(code: "return URLTransform(shouldEncodeURLString: \(encode))"))
    }
}
