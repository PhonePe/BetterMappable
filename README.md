# BetterMappable
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)](https://swift.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/BetterMappable.svg)](https://github.com/PhonePe/BetterMappable)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager](https://rawgit.com/jlyonsmith/artwork/master/SwiftPackageManager/swiftpackagemanager-compatible.svg)](https://swift.org/package-manager/)

Better Mappable utilising Swift 5 [`Property Wrappers`](https://nshipster.com/propertywrapper/) is a μframework written on top of [`ObjectMapper`](https://github.com/tristanhimmelman/ObjectMapper) that makes it easy to convert model objects (classes and structs) to and from JSON. Results in reduction of a lot of boiler plate code in models. 

# Index
- [JSONProperty](#JSONProperty)
- [JSONObject](#JSONObject)
- [JSONObjectArray](#JSONObjectArray)
- [JSONObjectDictionary](#JSONObjectDictionary)
- [JSONPropertyWithTransform](#JSONPropertyWithTransform)
- [JSONObjectDictionaryArrayValue](#JSONObjectDictionaryArrayValue)

# JSONProperty
Utilise this property wrapper to map any primitive variables (`Int`, `String`, `Bool` etc...)
```swift
struct User: Mappable {
    @JSONProperty var name: String?
    @JSONProperty var age: Int?
    @JSONProperty var onPhonePe: Bool?

    init?(map: Map) {
    }
}
```

That's it! For those who are familiar with `ObjectMapper`, yes, you do not have to implement `func mapping(map: Map)` at all. We automatically take the variable name and assign right value from/to JSON. Incase your variable name is different from the `key` in the JSON, you can provide it as a parameter in `JSONProperty`.
```swift
@JSONProperty(key: "on_phonepe") 
var onPhonePe: Bool?
```

You can provide default value to a variable like the way you generally do with `ObjectMapper`.
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

Like the `JSONProperty` example, if your variable name is different from the `key` in the JSON, you can provide it as a parameter in `JSONObject`.
```swift
@JSONObject(key: "student_address") 
var address: Address?
```

# JSONObjectArray
Use this property wrapper to map array of custom classes/structs which confirms to `Mappable` protocol
```swift
struct Store: Mappable {
    @JSONObjectArray var transactions: [Transaction]?
    
    @JSONProperty var name: String?
    
    init?(map: Map) {
    }
}

struct Transaction: Mappable {
    @JSONProperty var id: String?
    
    @JSONProperty var amount: Int = 0
    
    init?(map: Map) {
    }
}
```

# JSONObjectDictionary
Use this property wrapper to map dictionary of custom classes/structs which confirms to `Mappable` protocol
```swift
struct Categories: Mappable {
    @JSONObjectDictionary var data: [String: Category]?
    
    init?(map: Map) {
    }
}

struct Category: Mappable {
    @JSONProperty var id: String?
    @JSONProperty var name: String?
    
    init?(map: Map) {
    }
}
```

# JSONObjectDictionaryArrayValue
Use this property wrapper to map dictionary of custom array classes/structs which confirms to `Mappable` protocol
```swift
struct Categories: Mappable {
    @JSONObjectDictionaryArrayValue var data: [String: [Category]]?
    
    init?(map: Map) {
    }
}

struct Category: Mappable {
    @JSONProperty var id: String?
    @JSONProperty var name: String?
    
    init?(map: Map) {
    }
}
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

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate BetterMappable into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'BetterMappable', '~> 1.0'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate BetterMappable into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "PhonePe/BetterMappable" "1.0.1"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but BetterMappable does support its use on supported platforms.

Once you have your Swift package set up, adding BetterMappable as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/PhonePe/BetterMappable.git", .upToNextMajor(from: "1.0.0"))
]
```

# Credits
[Srikanth KV](https://twitter.com/SrikanthVKabadi)
