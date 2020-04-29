//
//  Student.swift
//  BetterMappable_Tests
//
//  Created by Srikanth KV on 18/02/20.
//

import Foundation
import ObjectMapper
import BetterMappable

struct Student: Mappable {
    @JSONProperty
    var firstName: String?
    
    @JSONProperty
    var lastName: String?
    
    @JSONObject
    var address: Address?
    
    init?(map: Map) {
        
    }
}

extension Student {
    init(firstName: String,
         lastName: String,
         address: Address?) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
    }
}

struct Address: Mappable {
    @JSONProperty
    var street: String?
    
    @JSONProperty
    var building: String?
    
    @JSONProperty
    var city: String?
    
    @JSONProperty
    var state: String?
    
    init?(map: Map) {
        
    }
}

extension Address {
    init(street: String? = nil,
         building: String? = nil,
         city: String? = nil,
         state: String? = nil) {
        self.street = street
        self.building = building
        self.city = city
        self.state = state
    }
}
