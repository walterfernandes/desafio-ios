
import XCTest
@testable import Desafio

class PullTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRepositoryInstaceWithObject() {
        
        let pull = Pull(with: ["title": "title" as AnyObject,
                                           "state": "opened" as AnyObject,
                                           "html_url": "https://developer.github.com/v3/" as AnyObject,
                                           "body": "body" as AnyObject,
                                           "user": ["login": "username" as AnyObject,
                                                     "avatar_url": "https://avatars.githubusercontent.com/u/10398885?v=3" as AnyObject] as AnyObject])
        
        XCTAssertEqual(pull?.title, "title")
        XCTAssertEqual(pull?.state, "opened")
        XCTAssertEqual(pull?.htmlURL, "https://developer.github.com/v3/")
        XCTAssertEqual(pull?.body, "body")
        XCTAssertNotNil(pull?.user)
        
    }

    func testRepositoryInstaceWithObjectWithOutBody() {
        
        let pull = Pull(with: ["title": "title" as AnyObject,
                               "state": "opened" as AnyObject,
                               "html_url": "https://developer.github.com/v3/" as AnyObject,
                               "user": ["login": "username" as AnyObject,
                                        "avatar_url": "https://avatars.githubusercontent.com/u/10398885?v=3" as AnyObject] as AnyObject])
        
        XCTAssertEqual(pull?.title, "title")
        XCTAssertEqual(pull?.state, "opened")
        XCTAssertEqual(pull?.htmlURL, "https://developer.github.com/v3/")
        XCTAssertNil(pull?.body)
        XCTAssertNotNil(pull?.user)
        
    }

    func testRepositoryInstaceWithObjectWithOutTitle() {
        
        let pull = Pull(with: ["state": "opened" as AnyObject,
                               "html_url": "https://developer.github.com/v3/" as AnyObject,
                               "user": ["login": "username" as AnyObject,
                                        "avatar_url": "https://avatars.githubusercontent.com/u/10398885?v=3" as AnyObject] as AnyObject])
        
        XCTAssertNil(pull)
        
    }

}
