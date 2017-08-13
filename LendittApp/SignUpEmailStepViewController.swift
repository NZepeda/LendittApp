
import UIKit
import TextFieldEffects


class SignUpEmailStepViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: HoshiTextField!
    
    var user = User();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user);
        setTextFieldDelegate();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setTextFieldDelegate(){
        emailTextField.delegate = self;
    }
    
    // Mark - Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let passwordStepVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PasswordStep") as? SignUpPasswordViewController {
            
            user.email = emailTextField.text;
            
            passwordStepVC.user = user;
            show(passwordStepVC, sender: self);
        }
        
        return true;
    }
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
