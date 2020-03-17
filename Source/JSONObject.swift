
//
//  MappedYo.swift
//  MappablePropertyWrappers
//
//  Created by Srikanth KV on 17/02/20.
//  Copyright © 2020 PhonePe. All rights reserved.
//

import Foundation
import ObjectMapper

@propertyWrapper
public final class JSONObject<Value: BaseMappable> {
    public let key: String?
    public var wrappedValue: Value?
    
    public convenience init(wrappedValue: Value?) {
        self.init(key: nil, wrappedValue: wrappedValue)
    }
    
    fileprivate init(key: String?, wrappedValue: Value?) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObject where Value: ExpressibleByNilLiteral {
    public convenience init() {
        self.init(key: nil, wrappedValue: nil)
    }
    
    public convenience init(key: String?) {
        self.init(key: key, wrappedValue: nil)
    }
}

extension JSONObject: JSONMappable {
    var injectedKey: String? {
        return key
    }
  
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
}
