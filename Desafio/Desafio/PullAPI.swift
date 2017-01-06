
import Alamofire

public struct PullStates {
    
    public var opened: UInt
    
    public var closed: UInt
    
    public init() {
        self.opened = 0
        self.closed = 0
    }
    
    public init(opened: UInt, closed: UInt) {
        self.opened = opened
        self.closed = closed
    }
}

class PullAPI {
    
    /// Get pull requests from a repository.
    ///
    /// - parameter owner:          The owner of repository.
    /// - parameter repositoryName: The repository's name.
    /// - parameter completion:     A closure to be executed once the request has finished.
    
    func get (_ owner: String, repositoryName:String, completion: @escaping ([Pull]?, PullStates?, Error?) -> Void) {
        
        let endPointURL = URL(string:"https://api.github.com/repos/\(owner)/\(repositoryName)/pulls?state=all")
        
        Alamofire.request(endPointURL!).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                print("sucess: ", value)
                
                guard let items = value as? [[String: AnyObject]] else {
                    completion(nil, nil, NSError.init(domain: "Malformed data received from fetchAllRooms service", code: 0, userInfo: nil))
                    return
                }
                
                var pullList: [Pull] = []
                
                for item in items {
                    if let pull = Pull(with: item) {
                        pullList.append(pull)
                    }
                }
                
                completion (pullList, self.countState(pullList), nil)
                
                break
            case .failure(let error):
                completion(nil, nil, error)
                break
            }
        }
    }
    
    private func countState (_ pullList:[Pull]) -> PullStates {
        var opened: UInt = 0
        var closed: UInt = 0
        
        for pull in pullList {
            if (pull.state == "open") {
                opened += 1
            } else if (pull.state == "closed") {
                closed += 1
            }
        }

        return PullStates(opened: opened, closed: closed)
    }

}
