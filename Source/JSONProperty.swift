//
//  JSONProperty.swift
//  BetterMappable
//
//  Created by Srikanth KV on 16/02/20.
//

import Foundation
import ObjectMapper

@propertyWrapper
public class JSONProperty<Value> {
    public let key: String?
    public var wrappedValue: Value
    
    public convenience init(wrappedValue: Value) {
        self.init(wrappedValue: wrappedValue, key: nil)
    }
    
    public init(wrappedValue: Value, key: String? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONProperty where Value: ExpressibleByNilLiteral {
    public convenience init(key: String? = nil) {
        self.init(wrappedValue: nil, key: key)
    }
}

extension JSONProperty: JSONPropertyMappable {
    var injectedKey: String? {
        return key
    }
    
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
}
