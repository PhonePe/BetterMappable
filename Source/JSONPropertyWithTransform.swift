//
//  JSONPropertyWithTransform.swift
//  BetterMappable
//
//  Created by Srikanth KV on 18/02/20.
//

import Foundation
import ObjectMapper

@propertyWrapper
public class JSONPropertyWithTransform<Value, Transformer: TransformType> {
    public let key: String?
    public var wrappedValue: Value?
    public let transformer: Transformer?
    
    public init(wrappedValue: Value? = nil, key: String? = nil, transformer: Transformer? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
        self.transformer = transformer
    }
}

extension JSONPropertyWithTransform: JSONPropertyMappable {
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
