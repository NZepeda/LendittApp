
import UIKit
import TextFieldEffects
import KeychainSwift

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var firstNameTextField: HoshiTextField!
    @IBOutlet var lastNameField: HoshiTextField!
    
    
    // Keychain 
    let keychain = KeychainSwift();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setTextFieldDelegates();
        
        setTextFieldObservers();
    }
    
    // Mark - Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let emailStepVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailStep") as? SignUpEmailStepViewController
        {
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
    
    func setTextFieldObservers(){
        
        // ** Set up keyboard listeners *//
        // Keyboard Will Show
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: .UIKeyboardWillShow,
                                               object: nil);
        
        // Keyboard Will Hide
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide,
                                               object: nil);
        
    }

    
    func getUnwrappedTextFromField(textField: UITextField) -> String {
        if let fieldText: String = textField.text {
            return fieldText;
        }
        
        return "";
    }
    
    func keyboardWillShow(notification: Notification) {
        
    }
    
    func keyboardWillHide(notification: Notification){
    }
    
    func getKeyBoardFrame(notification: Notification) -> NSValue{
        return (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    

}
