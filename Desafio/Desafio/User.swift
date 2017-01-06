
import Foundation

class User {
    
    var username: String
    var avatarURL: String
    
    init(_ username: String, avatarURL: String) {
        
        self.username = username
        self.avatarURL = avatarURL
    }
    
    convenience init? (with object:[String: AnyObject]) {
        
        guard let username = object["login"] as? String else {
            return nil
        }
        
        guard let avatarURL = object["avatar_url"] as? String else {
            return nil
        }
        
        self.init(username, avatarURL: avatarURL)
        
    }
}
