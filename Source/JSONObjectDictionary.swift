
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
public final class JSONObjectDictionary<Value: BaseMappable> {
    public let key: String?
    public var wrappedValue: [String: Value]?
    
    public convenience init(wrappedValue: [String: Value]?) {
        self.init(key: nil, wrappedValue: wrappedValue)
    }
    
    fileprivate init(key: String?, wrappedValue: [String: Value]?) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObjectDictionary where Value: ExpressibleByNilLiteral {
    public convenience init() {
        self.init(key: nil, wrappedValue: nil)
    }
    
    public convenience init(key: String?) {
        self.init(key: key, wrappedValue: nil)
    }
}

extension JSONObjectDictionary: JSONMappable {
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
    
    var injectedKey: String? {
        return key
    }
}
