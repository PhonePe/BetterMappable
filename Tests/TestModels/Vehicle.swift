//
//  Vehicle.swift
//  BetterMappable_Tests
//
//  Created by Srikanth KV on 18/02/20.
//

import Foundation
import ObjectMapper
import BetterMappable

class Vehicle {
    enum VehicleType: String {
        case car = "CAR"
        case bicycle = "BICYCLE"
    }
    
    @JSONProperty
    var numberOfWheels: Int?
}

extension Vehicle: StaticMappable {
    static func objectForMapping(map: Map) -> BaseMappable? {
        if let rawType = map.JSON["type"] as? String, let type = VehicleType(rawValue: rawType) {
            switch type {
            case .car:
                return Car()
                
            case .bicycle:
                return Bicycle()
            }
        }
        
        return nil
    }
}

class Car: Vehicle {
    @JSONProperty
    var hasBonet: Bool?
}

class Bicycle: Vehicle {
    @JSONProperty
    var modelName: String?
}
