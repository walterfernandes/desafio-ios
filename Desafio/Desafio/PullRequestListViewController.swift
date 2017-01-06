
import UIKit
import PKHUD

class PullRequestListViewController: UITableViewController {

    @IBOutlet weak var pullStatesLabel: UILabel!
    
    private let pullAPI = PullAPI()
    private var results: [Pull] = []
    
    var repository: Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120;
        
        pullStatesLabel.text = ""

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPullStates ( states: PullStates) {
        let openedString = "\(states.opened) opened"
        let closedString = "\(states.closed) closed"
        
        let attributedString = NSMutableAttributedString(string: "\(openedString) / \(closedString)", attributes: nil)
        
        let openedStringRange = (attributedString.string as NSString).range(of: openedString)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(0xdd910c), range: openedStringRange)

        self.pullStatesLabel.attributedText = attributedString
    }
    
    // MARK: - Data
    
    func loadData () {
        
        if let repo = repository {
            
            title = repo.name
            
            HUD.show(.progress)
            pullAPI.get(repo.owner.username, repositoryName: repo.name, completion: { (results, states, error) in
                
                if error == nil {
                    self.setPullStates(states: states!)
                    self.results.append(contentsOf: results!)
                    self.tableView.reloadData()
                } else {
                    UIAlertController.present(viewController: self, title: "Error", message: error?.localizedDescription, dissmisTitle: "OK");
                }
                
                HUD.hide()
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullCell", for: indexPath) as! PullCell
        
        let pull = results[indexPath.row]
        
        cell.titleLabel?.text = pull.title
        cell.bodyLabel?.text = pull.body
        cell.usernameLabel?.text = pull.user.username
        cell.userImageView?.setImage(with: URL(string:pull.user.avatarURL)!);

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pull = results[indexPath.row]
        UIApplication.shared.openURL(URL(string: pull.htmlURL)!)
    }
    
}
