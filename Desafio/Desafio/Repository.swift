
import Foundation

class Repository {
    
    var name: String
    var description: String
    var forks: Int
    var stargazersCount: Int
    var owner: User
    
    init(_ name: String,  description: String, forks: Int, stargazersCount: Int, owner: User) {
        
        self.name = name
        self.description = description
        self.forks = forks
        self.stargazersCount = stargazersCount
        self.owner = owner
        
    }
    
    convenience init? (with object: [String: AnyObject]) {
        
        guard let name = object["name"] as? String else {
            return nil
        }
        
        guard let description = object["description"] as? String else {
            return nil
        }
        
        guard let forks = object["forks"] as? Int else {
            return nil
        }

        guard let stargazersCount = object["stargazers_count"] as? Int else {
            return nil
        }
        
        guard let owner = User(with: object["owner"] as! [String : AnyObject]) else {
            return nil
        }
        
        self.init(name, description: description, forks: forks, stargazersCount: stargazersCount, owner: owner)
    }
    
}
