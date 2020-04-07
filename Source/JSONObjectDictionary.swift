
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
    
    public init(wrappedValue: [String: Value]? = nil, key: String? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
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
