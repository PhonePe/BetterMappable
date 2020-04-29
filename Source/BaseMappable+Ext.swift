//
//  BaseMappable+Ext.swift
//  BetterMappable
//
//  Created by Srikanth KV on 28/02/20.
//

import Foundation
import ObjectMapper

extension BaseMappable {
    public func mapping(map: Map) {
        func mapTo(mirror: Mirror?, from map: Map) {
            guard let mirror = mirror else {
                return
            }
            
            mapTo(mirror: mirror.superclassMirror, from: map)
            
            for child in mirror.children {
                guard let val = child.value as? JSONPropertyMappable else {
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
