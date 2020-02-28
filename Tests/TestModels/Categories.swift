//
//  Categories.swift
//  BetterMappable
//
//  Created by Srikanth KV on 28/02/20.
//  Copyright © 2020 PhonePe. All rights reserved.
//

import Foundation
import ObjectMapper
import BetterMappable

struct Categories: Mappable {
    
    @JSONObjectDictionary
    var data: [String: Category]?
    
    init?(map: Map) {
        
    }
}

struct Category: Mappable {
    
    @JSONProperty
    var id: String?
    
    @JSONProperty
    var name: String?
    
    init?(map: Map) {
        
    }
}
