import XCTest
import BetterMappable
import ObjectMapper

class BetterMappableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMappingJSONToClass() {
        // This is an example of a functional test case.
        
        let json = """
        {
            "name": "Srikanth",
            "age": 29,
            "organization_name": "PhonePe"
        }
        """
        
        guard let person = Mapper<Person>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(person.name, "Srikanth")
        XCTAssertEqual(person.age, 29)
        XCTAssertEqual(person.organization, "PhonePe")
    }
    
    func testMappingClassToJSON() {
        let personString: String? = Person(name: "Nayana", age: 24, organization: "Flipkart").toJSONString()
        XCTAssertNotNil(personString)
        
        if let uPersonString = personString,
            let personDict = toDict(jsonString: uPersonString) {
            XCTAssertEqual(personDict["name"] as? String, "Nayana")
            XCTAssertEqual(personDict["age"] as? Int, 24)
            // Should not contain "organization" key
            XCTAssertNil(personDict["organization"] as? String)
            XCTAssertEqual(personDict["organization_name"] as? String, "Flipkart")
        } else {
            XCTAssert(false)
        }
    }
    
    func testMappingNestedClassToJSON() {
        let json = """
        {
            "firstName": "Abhijith",
            "lastName": "KG",
            "address": {
                "city": "Bangalore",
                "state": "Karnataka",
            }
        }
        """
        
        guard let student = Mapper<Student>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(student.firstName, "Abhijith")
        XCTAssertEqual(student.lastName, "KG")
        
        XCTAssertNotNil(student.address)
        XCTAssertEqual(student.address?.city, "Bangalore")
        XCTAssertEqual(student.address?.state, "Karnataka")
        XCTAssertNil(student.address?.building)
        XCTAssertNil(student.address?.street)
    }
    
    func testMappingJSONToNestedClass() {
        let address = Address(city: "Bangalore", state: "Karnataka")
        let studentString = Student(firstName: "Srikanth", lastName: "Kabadi", address: address).toJSONString()
        
        XCTAssertNotNil(studentString)
        
        if let uStudentString = studentString,
            let studentDict = toDict(jsonString: uStudentString) {
            XCTAssertEqual(studentDict["firstName"] as? String, "Srikanth")
            XCTAssertEqual(studentDict["lastName"] as? String, "Kabadi")
            
            XCTAssertNotNil(studentDict["address"] as? [String: Any])
            
            if let addDict = studentDict["address"] as? [String: Any] {
                XCTAssertEqual(addDict["city"] as? String, "Bangalore")
                XCTAssertEqual(addDict["state"] as? String, "Karnataka")
            }
        } else {
            XCTAssert(false)
        }
    }
    
    func testStaticMappable() {
        let json = """
        {
            "type": "CAR",
            "numberOfWheels": 4,
            "hasBonet": true
        }
        """
        
        guard let vehicle = Mapper<Vehicle>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertNotNil(vehicle as? Car)
        
        if let car = vehicle as? Car {
            XCTAssertEqual(car.numberOfWheels, 4)
            XCTAssertEqual(car.hasBonet, true)
        }
    }
    
    func testTransform() {
        let json = """
        {
            "name": "PhonePe",
            "type": "PRIVATE",
            "date": 1582037267000
        }
        """
        
        guard let org = Mapper<Organization>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(org.name, "PhonePe")
        XCTAssertEqual(org.type?.rawValue, "PRIVATE")
        XCTAssertEqual(org.date?.timeIntervalSince1970, 1582037267000)
    }
    
    func testSubclass() {
        let json = """
        {
            "base": "Walmart",
            "sub": "PhonePe"
        }
        """
        
        guard let subclass = Mapper<Subclass>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(subclass.base, "Walmart")
        XCTAssertEqual(subclass.sub, "PhonePe")
    }
    
    func testJSONArray() {
        let json = """
        {
            "name": "Ganesh Textiles",
            "transactions": [
                {
                    "id": "T1234",
                    "amount": 100
                },
                {
                    "id": "T1456",
                    "amount": 200
                }
            ]
        }
        """
        
        guard let store = Mapper<Store>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(store.name, "Ganesh Textiles")
        XCTAssertEqual(store.transactions?.count, 2)
        XCTAssertEqual(store.transactions?.first?.id, "T1234")
        XCTAssertEqual(store.transactions?.last?.amount, 200)
    }
    
    func testJSONDictionary() {
        let json = """
        {
            "data": {
                "food": {
                    "id": "T1234",
                    "name": "Food"
                },
                "travel": {
                    "id": "T1456",
                    "name": "Travel"
                }
            }
        }
        """
        
        guard let categories = Mapper<Categories>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertNotNil(categories.data)
        XCTAssertEqual(categories.data?.count, 2)
        XCTAssertNotNil(categories.data?["food"])
        XCTAssertNotNil(categories.data?["travel"])
        XCTAssertEqual(categories.data?["food"]?.name, "Food")
        XCTAssertEqual(categories.data?["travel"]?.name, "Travel")
    }
    
    func testJSONPropertyDictionary() {
        let json = """
        {
            "data": {
                "id": "T1234",
                "name": "Food"
            }
        }
        """
        
        guard let stringOfString = Mapper<StringOfString>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertNotNil(stringOfString.data)
        XCTAssertEqual(stringOfString.data?.count, 2)
        XCTAssertEqual(stringOfString.data?["id"], "T1234")
        XCTAssertEqual(stringOfString.data?["name"], "Food")
    }
    
    func testJSONDictionaryArrayValue() {
        let json = """
        {
            "data": {
                "food": [
                    {
                        "id": "T1234",
                        "name": "Food"
                    },
                    {
                        "id": "T3456",
                        "name": "Water"
                    }
                ],
                "travel": [
                    {
                        "id": "T1456",
                        "name": "Travel"
                    },
                    {
                        "id": "T1678",
                        "name": "Space"
                    }
                ]
            }
        }
        """
        
        guard let categories = Mapper<CategoriesDictArrayValue>().map(JSONString: json) else {
            XCTAssert(false)
            return
        }
        
        XCTAssertNotNil(categories.data)
        XCTAssertEqual(categories.data?.count, 2)
        XCTAssertNotNil(categories.data?["food"])
        XCTAssertNotNil(categories.data?["travel"])
        XCTAssertEqual(categories.data?["food"]?.first?.name, "Food")
        XCTAssertEqual(categories.data?["travel"]?.last?.name, "Space")
    }
    
    private func toDict(jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
}
