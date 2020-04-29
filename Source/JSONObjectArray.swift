//
//  JSONObjectArray.swift
//  BetterMappable
//
//  Created by Srikanth KV on 17/02/20.
//

import Foundation
import ObjectMapper

@propertyWrapper
public final class JSONObjectArray<Value: BaseMappable> {
    public let key: String?
    public var wrappedValue: [Value]?
    
    public init(wrappedValue: [Value]? = nil, key: String? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObjectArray: JSONPropertyMappable {
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
    
    var injectedKey: String? {
        return key
    }
}
