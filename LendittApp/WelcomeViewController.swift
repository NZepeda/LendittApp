import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!;
    
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad();
        setupView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        nameLabel.text = name;
    }

}
