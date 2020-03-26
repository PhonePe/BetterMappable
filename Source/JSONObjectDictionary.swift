
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
        self.init(wrappedValue: wrappedValue, key: nil)
    }
    
    fileprivate init(wrappedValue: [String: Value]?, key: String?) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObjectDictionary where Value: ExpressibleByNilLiteral {
    public convenience init() {
        self.init(wrappedValue: nil, key: nil)
    }
    
    public convenience init(key: String?) {
        self.init(wrappedValue: nil, key: key)
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
