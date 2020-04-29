//
//  JSONObject.swift
//  BetterMappable
//
//  Created by Srikanth KV on 17/02/20.
//

import Foundation
import ObjectMapper

@propertyWrapper
public final class JSONObject<Value: BaseMappable> {
    public let key: String?
    public var wrappedValue: Value?
    
    public init(wrappedValue: Value? = nil, key: String? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObject: JSONPropertyMappable {
    var injectedKey: String? {
        return key
    }
    
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
}
