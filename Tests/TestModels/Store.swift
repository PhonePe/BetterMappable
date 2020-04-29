//
//  Store.swift
//  BetterMappable_Tests
//
//  Created by Srikanth KV on 28/02/20.
//

import Foundation
import ObjectMapper
import BetterMappable

struct Store: Mappable {
    
    @JSONObjectArray
    var transactions: [Transaction]?
    
    @JSONProperty
    var name: String?
    
    init?(map: Map) {
        
    }
}

struct Transaction: Mappable {
    
    @JSONProperty
    var id: String?
    
    @JSONProperty
    var amount: Int = 0
    
    init?(map: Map) {
        
    }
}
