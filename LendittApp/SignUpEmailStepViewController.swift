
import UIKit
import TextFieldEffects


class SignUpEmailStepViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: HoshiTextField!
    
    var user = User();
    
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
    
    // Mark - Helper Methods
    func getUnwrappedTextFromField(textField: UITextField) -> String {
        if let fieldText: String = textField.text {
            return fieldText;
        }
        
        return "";
    }
    
    // Mark - Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let universityStepVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UniversityStep") as? SignUpUniversityViewController {
            
            user.email = getUnwrappedTextFromField(textField: emailTextField);
            
            universityStepVC.user = user;
            show(universityStepVC, sender: self);
        }
        
        return true;
    }
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
