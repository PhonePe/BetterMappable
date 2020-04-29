//
//  Organization.swift
//  BetterMappable
//
//  Created by Srikanth KV on 18/02/20.
//

import Foundation
import ObjectMapper
import BetterMappable

struct Organization: Mappable {
    enum OrgType: String {
        case `private` = "PRIVATE"
        case `public` = "PUBLIC"
    }
    
    @JSONProperty
    var name: String?
    
    @JSONPropertyWithTransform(transformer: DateTransform())
    var date: Date?
    
    @JSONPropertyWithTransform(transformer: EnumTransform<OrgType>())
    var type: OrgType?
    
    init?(map: Map) {
        
    }
}
