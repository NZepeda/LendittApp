
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
        let data = ["firstName" : user.firstName!,
                    "lastName": user.lastName!,
                    "email" : user.email!,
                    "password": getUnwrappedTextFromField(textField: passwordTextField)]
        
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/register", method: .post, parameters: data, encoding: URLEncoding.default).response{ (response) in
            
            let json = JSON(data: response.data!);
            
            if(json["success"]).boolValue == true{
                print("AUTHENTICATE AND CREATE SUCCESS PAGE");
            }
        }
    }
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
