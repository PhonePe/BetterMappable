//
//  Person.swift
//  BetterMappable_Tests
//
//  Created by Srikanth KV on 24/02/20.
//

import Foundation
import ObjectMapper
import BetterMappable

struct Person: Mappable {
    
    @JSONProperty
    var name: String?
    
    @JSONProperty
    var age: Int?
    
    @JSONProperty(key: "organization_name")
    var organization: String?
    
    init?(map: Map) {
        
    }
}

extension Person {
    init(name: String, age: Int, organization: String? = nil) {
        self.name = name
        self.age = age
        self.organization = organization
    }
}
