//
//  JSONPropertyMappable.swift
//  BetterMappable
//
//  Created by Srikanth KV on 28/02/20.
//

import Foundation
import ObjectMapper

protocol JSONPropertyMappable: class {
    var injectedKey: String? { get }
    func mapValue(from map: Map, key: String)
}
