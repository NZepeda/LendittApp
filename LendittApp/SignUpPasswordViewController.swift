
import UIKit
import TextFieldEffects
import Alamofire

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        registerUser();
        
        return true;
    }
    
    func registerUser(){
        let data = ["firstName" : user.firstName,
                    "lastName": user.lastName,
                    "email" : user.email,
                    "password": passwordTextField.text];
        
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/register", method: .post, parameters: data, encoding: URLEncoding.default).validate(statusCode: 200..<201).responseData { (response) in
            print(response);
        }
    }
    
    // Mark - IBActions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

}
