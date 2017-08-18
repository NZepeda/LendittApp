
import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON

class SignUpPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordTextField: HoshiTextField!
    
    var user = User();
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func proceedToWelcomeScreen () {
        if let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreen") as? WelcomeViewController {
            
            print("Moving to the welcome screen");
            
            welcomeVC.name = user.firstName;
            show(welcomeVC, sender: self);
        }
    }
    
    // Mark - Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        registerUser();
        
        return true;
    }
    
    func registerUser(){
        
        let data = getData();
        
        ApiController.register(data, completionHandler: { response, error in
            
            if(response)! {
                ApiController.authenticate(data, completionHandler: { (result, error) in
                    print(result);
                    if result == true {
                        self.proceedToWelcomeScreen();
                    }
                    else{
                        print("There was an error and could not present the welcome screen");
                    }
                })
            }
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
