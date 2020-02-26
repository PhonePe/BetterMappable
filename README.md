# BetterMappable
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)](https://swift.org)

Better Mappable through Property Wrappers is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON with the help of [`ObjectMapper`](https://github.com/tristanhimmelman/ObjectMapper). Helps you in reducing a lot of boiler plate code in your models. 

# The Basics
3 property wrappers are provided for your use:
- [JSONProperty](#JSONProperty)
- [JSONObject](#JSONObject)
- [JSONPropertyWithTransform](#JSONPropertyWithTransform)

# JSONProperty
Use this property wrapper to map any primitive variables (`Int`, `String`, `Bool` etc...)
```swift
struct User: Mappable {
    @JSONProperty var name: String?
    @JSONProperty var age: Int?
    @JSONProperty var onPhonePe: Bool?

    init?(map: Map) {
    }
}
```

That's it. Yes!! you read it right. You need not have to implement `func mapping(map: Map)` at all. We automatically take the variable name and assign right value from/to JSON. Incase your variable name is different from the `key` in the JSON, you can provide it as a parameter in `JSONProperty`.
```swift
@JSONProperty(key: "on_phonepe") 
var onPhonePe: Bool?
```

You can provide the default value to a variable like the way you generally do with `ObjectMapper`.
```swift
@JSONProperty 
var age: Int = 0
    
@JSONProperty(key: "on_phonepe")
var onPhonePe: Bool = false
```

# JSONObject
Use this property wrapper to map custom classes/structs which confirms to `Mappable` protocol
```swift
struct Student: Mappable {
    @JSONObject var address: Address?
    
    @JSONProperty var firstName: String?
    @JSONProperty var lastName: String?
    
    init?(map: Map) {
    }
}

struct Address: Mappable {
    @JSONProperty var street: String?
    @JSONProperty var building: String?
    @JSONProperty var city: String?
    @JSONProperty var state: String?
    
    init?(map: Map) {
        
    }
}
```

Similar to `JSONProperty` example, incase your variable name is different from the `key` in the JSON, you can provide it as a parameter in `JSONObject`.
```swift
@JSONObject(key: "student_address") 
var address: Address?
```

# JSONPropertyWithTransform
Use this property wrapper to map variables with transformation.
```swift
struct Organization: Mappable {
    enum Sector: String {
        case `private` = "PRIVATE"
        case `public` = "PUBLIC"
    }
    
    @JSONPropertyWithTransform(transformer: DateTransform())
    var startDate: Date?
    
    @JSONPropertyWithTransform(transformer: EnumTransform<Sector>())
    var sector: Sector?
    
    @JSONProperty var name: String?
    
    init?(map: Map) {
    }
}
```

# Does this work with StaticMappable?`
Yes it does. 
```swift
class Vehicle {
    enum VehicleType: String {
        case car = "CAR"
        case bicycle = "BICYCLE"
    }
    
    @JSONProperty var numberOfWheels: Int?
}

extension Vehicle: StaticMappable {
    static func objectForMapping(map: Map) -> BaseMappable? {
        if let rawType = map.JSON["type"] as? String,
            let type = VehicleType(rawValue: rawType) {
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
    @JSONProperty var hasBonet: Bool?
}

class Bicycle: Vehicle {
    @JSONProperty var modelName: String?
}
```

# Subclasses
```swift
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
```
