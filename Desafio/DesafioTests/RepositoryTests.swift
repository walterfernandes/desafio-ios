
import XCTest
@testable import Desafio


class RepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
     }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRepositoryInstaceWithObject() {
        
        let repository = Repository(with: ["name": "name" as AnyObject,
                                           "description": "description" as AnyObject,
                                           "forks": 1 as AnyObject,
                                           "stargazers_count": 1 as AnyObject,
                                           "owner": ["login": "username" as AnyObject,
                                                     "avatar_url": "https://avatars.githubusercontent.com/u/10398885?v=3" as AnyObject] as AnyObject])
        
        XCTAssertEqual(repository?.name, "name")
        XCTAssertEqual(repository?.description, "description")
        XCTAssertEqual(repository?.forks, 1)
        XCTAssertEqual(repository?.stargazersCount, 1)
        XCTAssertNotNil(repository?.owner)
        
    }
    
}
