//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Berkay YAY on 7.12.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailLabel.text == "" {
            self.showAlert(title: "Error", message: "Email not found!")
            
        } else if passwordLabel.text == "" {
            self.showAlert(title: "Error", message: "Password not found!")
            
        } else{
            guard let email = emailLabel.text,
                  let password = passwordLabel.text else{
                self.showAlert(title: "Error", message: "Username/Password not found!")
                return
            }
            Auth.auth().createUser(withEmail: email, password: password) { authData, error in
                if error != nil {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")

                } else {
                    self.showAlert(title: "Success", message: "Signed up successfully")
                    
                }
            }
        }
        
       
        
        
        
        
    }
    @IBAction func signInClicked(_ sender: Any) {
        guard let email = emailLabel.text,
              let password = passwordLabel.text else {
            self.showAlert(title: "Error", message: "Username/Password not found!")
            return
        }
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email, password: password) { authData, error in
                if error != nil {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")

                } else {
                    self.navigateHomepage(title: "Success", message: "Welcome Berkay!")
                    
                }
            }
        }
        
        

    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func navigateHomepage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
}

