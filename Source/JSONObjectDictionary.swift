//
//  JSONObjectDictionary.swift
//  BetterMappable
//
//  Created by Srikanth KV on 17/02/20.
//

import Foundation
import ObjectMapper

@propertyWrapper
public final class JSONObjectDictionary<Value: BaseMappable> {
    public let key: String?
    public var wrappedValue: [String: Value]?
    
    public init(wrappedValue: [String: Value]? = nil, key: String? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObjectDictionary: JSONPropertyMappable {
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
    
    var injectedKey: String? {
        return key
    }
}
