
import UIKit

class LandingPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarStyle();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setNavBarStyle(){
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
    @IBAction func loginButtonClicked(_ sender: UIButton) {
       
    }

}

