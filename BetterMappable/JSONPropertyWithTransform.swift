//
//  JSONPropertyWithTransform.swift
//  MappablePropertyWrappers
//
//  Created by Srikanth KV on 18/02/20.
//  Copyright © 2020 PhonePe. All rights reserved.
//

import Foundation
import ObjectMapper

@propertyWrapper
public class JSONPropertyWithTransform<Value, Transformer: TransformType> {
    public let key: String?
    public var wrappedValue: Value
    public let transformer: Transformer?
    
    public convenience init(wrappedValue: Value) {
        self.init(wrappedValue: wrappedValue, key: nil, transformer: nil)
    }
    
    public init(wrappedValue: Value, key: String?, transformer: Transformer?) {
        self.key = key
        self.wrappedValue = wrappedValue
        self.transformer = transformer
    }
}

extension JSONPropertyWithTransform where Value: ExpressibleByNilLiteral {
    public convenience init() {
        self.init(wrappedValue: nil, key: nil, transformer: nil)
    }
    
    public convenience init(key: String?) {
        self.init(wrappedValue: nil, key: key, transformer: nil)
    }
    
    public convenience init(transformer: Transformer) {
        self.init(wrappedValue: nil, key: nil, transformer: transformer)
    }
}

extension JSONPropertyWithTransform: JSONMappable {
    var injectedKey: String? {
        return key
    }
    
    func mapValue(from map: Map, key: String) {
        switch map.mappingType {
        case .fromJSON:
            var wv: Transformer.Object?
            
            if let uTransformer = transformer {
                wv <- (map[key], uTransformer)
            }
            
            if let uWrappedValue = wv as? Value {
                wrappedValue = uWrappedValue
            }
            
        case .toJSON:
            var wv = wrappedValue as? Transformer.Object
            
            if let uTransformer = transformer {
                wv <- (map[key], uTransformer)
            }
        }
    }
}
