//
//  Mapped.swift
//  TestPropertyWrappers
//
//  Created by Srikanth KV on 16/02/20.
//  Copyright © 2020 PhonePe. All rights reserved.
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
    
    public init(wrappedValue: Value, key: String?) {
        self.key = key
        self.wrappedValue = wrappedValue
    }
}

extension JSONProperty where Value: ExpressibleByNilLiteral {
    public convenience init() {
        self.init(wrappedValue: nil, key: nil)
    }
    
    public convenience init(key: String?) {
        self.init(wrappedValue: nil, key: key)
    }
}

extension BaseMappable {
    public func mapping(map: Map) {
        func mapTo(mirror: Mirror?, from map: Map) {
            guard let mirror = mirror else {
                return
            }
            
            mapTo(mirror: mirror.superclassMirror, from: map)
            
            for child in mirror.children {
                guard let val = child.value as? JSONMappable else {
                    continue
                }
                
                var key = val.injectedKey
                if key == nil {
                    // No key provided. Using the name of the variable itself as the key
                    key = child.label
                    key?.removeFirst()  // removing first character `_` as it is added by propertyWrappers
                }
                
                if let unwrappedKey = key {
                    val.mapValue(from: map, key: unwrappedKey)
                }
            }
        }
        
        let selfMirror = Mirror(reflecting: self)
        mapTo(mirror: selfMirror, from: map)
    }
}

protocol JSONMappable {
    var injectedKey: String? { get }
    func mapValue(from map: Map, key: String)
}

extension JSONProperty: JSONMappable {
    var injectedKey: String? {
        return key
    }
    
    func mapValue(from map: Map, key: String) {
        wrappedValue <- map[key]
    }
}
