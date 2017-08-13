
import UIKit
import TextFieldEffects
import KeychainSwift

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var firstNameTextField: HoshiTextField!
    @IBOutlet var lastNameField: HoshiTextField!
    
    
    // Keychain 
    let keychain = KeychainSwift();
    var user = User();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setTextFieldDelegates();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        
    }
    
    // Mark - Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let emailStepVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailStep") as? SignUpEmailStepViewController
        {
            // Mark - TODO
            // ** Ensure fields are valid before allowing user to proceed ** 
            
            user.firstName = getUnwrappedTextFromField(textField: firstNameTextField);
            user.lastName = getUnwrappedTextFromField(textField: lastNameField);
            
            emailStepVC.user = user;
            show(emailStepVC, sender: self);
        }

        return true;
    }
    

    // Mark - Helper Methods
    func setTextFieldDelegates(){
        firstNameTextField.delegate = self;
        lastNameField.delegate = self;
    }
    
    func fieldsAreValid() -> Bool{
        if(firstNameFieldIsValid() && lastNameFieldIsValid()){
            return true;
        }
        return false;
    }
    
    func firstNameFieldIsValid() -> Bool {
        if (firstNameTextField.text == ""){
            firstNameTextField.borderInactiveColor = UIColor.red;
            return false;
        }
        
        firstNameTextField.borderInactiveColor = UIColor.clear;
        return true;
    }
    
    func lastNameFieldIsValid() -> Bool {
        if(lastNameField.text == "") {
            lastNameField.borderInactiveColor = UIColor.red;
            return false;
        }
        lastNameField.borderInactiveColor = UIColor.clear;
        return true;
    }

    func getUnwrappedTextFromField(textField: UITextField) -> String {
        if let fieldText: String = textField.text {
            return fieldText;
        }
        
        return "";
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    

}
