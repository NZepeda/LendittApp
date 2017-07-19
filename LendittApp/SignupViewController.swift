
import UIKit
import TextFieldEffects
import Alamofire
import KeychainSwift
import SwiftyJSON

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var firstNameTextField: HoshiTextField!
    @IBOutlet var lastNameField: HoshiTextField!
    @IBOutlet var emailTextField: HoshiTextField!
    @IBOutlet var passwordTextField: HoshiTextField!
    
    
    // Keychain 
    let keychain = KeychainSwift();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let token = retrieveTokenFromKeychain();
        
        setTextFieldDelegates();
        //hitProtectedEndpoint();
        
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
    
    // Mark - Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(fieldsAreValid()){
            let data = ["firstName": getUnwrappedTextFromField(textField: firstNameTextField),
                        "lastName": getUnwrappedTextFromField(textField: lastNameField),
                        "email": getUnwrappedTextFromField(textField: emailTextField),
                        "password": getUnwrappedTextFromField(textField: passwordTextField)]
            
            Alamofire.request("https://lendittapi.herokuapp.com/api/v1/register", method: .post, parameters: data, encoding: URLEncoding.default).validate(statusCode: 200..<201).responseJSON { response in
                print(response);
                // Store token in keychain
                self.requestTokenFromServer(email: data["email"]!, password: data["password"]!);
            };
        }
        
        return true;
    }
    
    func requestTokenFromServer(email: String, password: String){
        let data = ["email": email, "password":password];
        
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/authenticate", method: .post, parameters: data, encoding: URLEncoding.default).validate(statusCode: 200..<201).response { response in
            
            let json = JSON(data: response.data!)
            
            if let token : String = json["token"].string {
                self.saveTokenToKeychain(token: token);
            }
            
        }
    }
    
    func retrieveTokenFromKeychain() -> String? {
        if let token: String = keychain.get("authToken") {
            return token;
        }
        else {
            return nil;
        }
    }
    
    func saveTokenToKeychain(token: String){
        if(keychain.set(token, forKey: "authToken")){
            print("Saved to keychain!");
        }
        else{
            print(keychain.lastResultCode);
        }
    }

    // Mark - Helper Methods
    func setTextFieldDelegates(){
        firstNameTextField.delegate = self;
        lastNameField.delegate = self;
        emailTextField.delegate = self;
        passwordTextField.delegate = self;
    }
    
    func fieldsAreValid() -> Bool{
        if(firstNameFieldIsValid() && lastNameFieldIsValid() && emailFieldIsValid() && passwordIsValid()){
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
    
    // ToDo - Add validation to ensure that this is a valid .edu email
    func emailFieldIsValid() -> Bool {
        if(emailTextField.text == ""){
            emailTextField.borderInactiveColor = UIColor.red;
            return false;
        }
        
        emailTextField.borderInactiveColor = UIColor.clear;
        return true;
    }
    
    // ToDo - Add password min requirements
    func passwordIsValid() -> Bool{
        if(passwordTextField.text == ""){
            passwordTextField.borderInactiveColor = UIColor.red;
            return false;
        }
        
        passwordTextField.borderInactiveColor = UIColor.clear;
        return true;
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
