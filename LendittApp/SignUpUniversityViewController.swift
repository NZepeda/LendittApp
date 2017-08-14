
import UIKit
import TextFieldEffects

class SignUpUniversityViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var universityTextField: HoshiTextField!
    
    var user = User();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldDelegate();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Mark - Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let passwordStepVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PasswordStep") as? SignUpPasswordViewController {
            
            user.school = getUnwrappedTextFromField(textField: universityTextField);
            
            passwordStepVC.user = user;
            show(passwordStepVC, sender: self);
        }
        
        return true;
    }
    
    // Mark - Helper Methods
    func setTextFieldDelegate(){
        universityTextField.delegate = self;
    }
    
    func getUnwrappedTextFromField(textField: UITextField) -> String {
        if let fieldText: String = textField.text {
            return fieldText;
        }
        
        return "";
    }
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
