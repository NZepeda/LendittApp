
import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
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

    // Mark - Helper Methods
    func keyboardWillShow(notification: Notification) {
        let keyboardFrame = getKeyBoardFrame(notification: notification).cgRectValue;
        goButton.frame.origin.y = keyboardFrame.origin.y - goButton.frame.height;
        
    }
    
    func keyboardWillHide(notification: Notification){
        let keyboardFrame = getKeyBoardFrame(notification: notification).cgRectValue;
        goButton.frame.origin.y = keyboardFrame.origin.y + goButton.frame.height;
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
