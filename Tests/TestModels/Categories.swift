//
//  Categories.swift
//  BetterMappable_Tests
//
//  Created by Srikanth KV on 28/02/20.
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

struct StringOfString: Mappable {
    @JSONProperty var data: [String: String]?
    
    init?(map: Map) {
        
    }
}

struct CategoriesDictArrayValue: Mappable {
    
    @JSONObjectDictionaryArrayValue
    var data: [String: [Category]]?
    
    init?(map: Map) {
        
    }
}
