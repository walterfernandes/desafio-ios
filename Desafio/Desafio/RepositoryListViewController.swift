
import UIKit
import PKHUD
import Alamofire
import AlamofireImage

class RepositoryListViewController: UITableViewController, UISearchBarDelegate {

    private let repositoryAPI = RepositoryAPI()
    private var results: [Repository] = []
    private var isLoading = false
    private var searchTimer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120;
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = (sender as! RepositoryCell).tag
        
        let repository = results[index]
        
        let pullViewController = segue.destination as? PullRequestListViewController
        
        pullViewController?.repository = repository
        
    }
    
    // MARK: data
    
    func loadData () {
        HUD.show(.progress)
        isLoading = true
        repositoryAPI.get { (results, error) in
            
            if error == nil {
                self.results.append(contentsOf: results!)
                self.tableView.reloadData()
            } else {
                UIAlertController.present(viewController: self, title: "Error", message: error?.localizedDescription, dissmisTitle: "OK");
            }
            
            self.isLoading = false
            HUD.hide()
        }
    }
    
    func nextData () {
        
        isLoading = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        repositoryAPI.getNextPage { (results, error) in
            if error == nil {
                self.results.append(contentsOf: results!)
                self.tableView.reloadData()
            }
            
            self.isLoading = false
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }
    
    func searchData () {
        
        isLoading = true
        
        let searchText = searchTimer?.userInfo
        
        results.removeAll()
        HUD.show(.progress)
        repositoryAPI.get(searchText as! String?, page: 1) { (results, error) in
            if error == nil {
                self.results.append(contentsOf: results!)
                self.tableView.reloadData()
            }
            
            self.isLoading = false
            HUD.hide()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
 
        let repository = results[indexPath.row]
        
        cell.nameLabel?.text = repository.name
        cell.descriptionLabel?.text = repository.description
        cell.forksLabel?.text = "\(repository.forks)"
        cell.starsLabel?.text = "\(repository.stargazersCount)"
        cell.usernameLabel?.text = repository.owner.username
        
        cell.userImageView?.setImage(with: URL(string:repository.owner.avatarURL)!)
        
        //use in prepare for segue
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (results.count - 2) && !isLoading {
            self.nextData()
        }
    }

    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if let timer = searchTimer {
            timer.invalidate()
        }
        
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(RepositoryListViewController.searchData), userInfo: searchText, repeats: false)
        
    }
    

}
