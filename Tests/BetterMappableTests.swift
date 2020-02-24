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
    
    func testMappingToClass() {
        // This is an example of a functional test case.
        
        let json = """
        {
            "name": "Srikanth",
            "age": 29,
            "organization_name": "PhonePe"
        }
        """
        
        guard let person = Mapper<Person>().map(JSONString: json) else {
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
            XCTAssertEqual(personDict["organization_name"] as? String, "Flipkart")
        } else {
            XCTAssert(false)
        }
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
