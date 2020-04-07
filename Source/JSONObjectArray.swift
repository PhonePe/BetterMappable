
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
public final class JSONObjectArray<Value: BaseMappable> {
    public let key: String?
    public var wrappedValue: [Value]?
    
    public init(wrappedValue: [Value]? = nil, key: String? = nil) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONObjectArray: JSONMappable {
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
    
    var injectedKey: String? {
        return key
    }
}
