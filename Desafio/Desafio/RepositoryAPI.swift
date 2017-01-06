
import Alamofire

class RepositoryAPI {
    
    var query: String?
    var page: Int = 1
    
    /// Get the repositories asynchronously, searching by query.
    ///
    /// - parameter query:      The search query.
    /// - parameter page:       The start Page, begins in 1.
    /// - parameter completion: A closure to be executed once the request has finished.

    func get (_ withQuery: String?, page: Int, completion: @escaping ([Repository]?, Error?) -> Void) {
        
        self.page = page
        self.query = withQuery
        
        let urlQuary = ((query == nil || (query?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)!) ? "language:Java" : "\(query!)+language:Java")
        
        let endPointURL = URL(string: "https://api.github.com/search/repositories?q=\(urlQuary)&sort=stars&page=\(page)")
        
        Alamofire.request(endPointURL!).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                guard let value = value as? [String: AnyObject], let items = value["items"] as? [[String: AnyObject]] else {
                        completion(nil, NSError.init(domain: "Malformed data received from fetchAllRooms service", code: 0, userInfo: nil))
                        return
                }
                
                var repositoryList: [Repository] = []
                
                for item in items {
                    if let repository = Repository(with: item) {
                        repositoryList.append(repository)
                    }
                }
                
                completion (repositoryList, nil)
                
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    /// Get the first page of repositories asynchronously
    ///
    /// - parameter completion: A closure to be executed once the request has finished.
    func get (_ completion: @escaping ([Repository]?, Error?) -> Void) {
        get(nil, page: 1, completion: completion)
    }

    /// Get the next page of repositories asynchronously
    ///
    /// - parameter completion: A closure to be executed once the request has finished.
    func getNextPage (_ completion: @escaping ([Repository]?, Error?) -> Void) {
        get(self.query, page: self.page+1, completion: completion);
    }
    
}
