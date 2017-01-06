
import XCTest
@testable import Desafio

class DesafioTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserInstance() {
        let user = User("username", avatarURL: "https://avatars.githubusercontent.com/u/10398885?v=3")

        XCTAssertEqual(user.username, "username")
        XCTAssertEqual(user.avatarURL, "https://avatars.githubusercontent.com/u/10398885?v=3")
        
    }
    
    func testUserInstaceWithObject() {
        
        let user = User(with: ["login": "username" as AnyObject, "avatar_url": "https://avatars.githubusercontent.com/u/10398885?v=3" as AnyObject])
        
        XCTAssertEqual(user?.username, "username")
        XCTAssertEqual(user?.avatarURL, "https://avatars.githubusercontent.com/u/10398885?v=3")
        
    }
    
    func testUserInstaceWithoutUsername() {
        let user = User(with: ["avatar_url": "https://avatars.githubusercontent.com/u/10398885?v=3" as AnyObject])
        
        XCTAssertNil(user)
        
    }
    
    func testUserInstaceWithoutAvatarURL() {
        let user = User(with: ["username": "username" as AnyObject])
        
        XCTAssertNil(user)
        
    }
    
}
