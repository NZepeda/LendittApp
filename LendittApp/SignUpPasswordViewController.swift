
import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON

class SignUpPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordTextField: HoshiTextField!
    
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
        passwordTextField.delegate = self;
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
        
        registerUser();
        
        return true;
    }
    
    func registerUser(){
        print("In the register user function!");
        let data = getData();
        ApiController.register(data, completionHandler: { response, error in
            print("Response: \(response)");
            print("Error: \(error)");
        });
    }
    
    func getData() -> [String: String] {
        let data = ["firstName": user.firstName!,
                    "lastName": user.lastName!,
                    "email": user.email!,
                    "school": user.school!,
                    "password": getUnwrappedTextFromField(textField: passwordTextField)];
        
        return data;
    }
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
