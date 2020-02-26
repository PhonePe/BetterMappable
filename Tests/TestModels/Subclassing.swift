//
//  Subclassing.swift
//  BetterMappable_Tests
//
//  Created by Srikanth KV on 26/02/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper
import BetterMappable

class Base: Mappable {
    @JSONProperty var base: String?
    
    required init?(map: Map) {
    }
}

class Subclass: Base {
    @JSONProperty var sub: String?

    required init?(map: Map) {
        super.init(map: map)
    }
}
