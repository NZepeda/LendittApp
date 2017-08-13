
import UIKit
import TextFieldEffects


class SignUpEmailStepViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            
            show(passwordStepVC, sender: self);
        }
        
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
