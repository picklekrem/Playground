//
//  AuthViewController.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 18.01.2021.
//

import UIKit
import Firebase

class AuthViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var fullnameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    let firestoredatabase = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        fullnameText.layer.cornerRadius = fullnameText.frame.size.height/2
        fullnameText.layer.borderWidth = 1.5
        fullnameText.layer.borderColor = UIColor.rgb(r: 46, g: 213, b: 115).cgColor
        fullnameText.clipsToBounds = true
        
        emailText.layer.cornerRadius = emailText.frame.size.height/2
        emailText.layer.borderWidth = 1.5
        emailText.layer.borderColor = UIColor.rgb(r: 46, g: 213, b: 115).cgColor
        emailText.clipsToBounds = true
        
        passwordText.layer.cornerRadius = passwordText.frame.size.height/2
        passwordText.layer.borderWidth = 1.5
        passwordText.layer.borderColor = UIColor.rgb(r: 46, g: 213, b: 115).cgColor
        passwordText.clipsToBounds = true
        
        fullnameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicVc"{
            let destinationController = segue.destination as! PhotoViewController
            destinationController.namelabelText = fullnameText.text!
        }
    }
    @IBAction func signupClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" && fullnameText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again")
                }
                else {
                    let userDictinoary = ["Email" : self.emailText.text!, "Fullname": self.fullnameText.text!, "Password" : self.passwordText.text!, "Times" : 0] as [String : Any]
                    self.firestoredatabase.collection("Usernames").document(Auth.auth().currentUser!.email!).setData(userDictinoary)
                    self.performSegue(withIdentifier: "toPicVc", sender: nil)
                }
            }
            
        }else
        {
            makeAlert(titleInput: "Error!", messageInput: "Kullanıcı adı veya Şifre hatalı/boş")
        }
        print("i clicked")
    }
    
    
    @IBAction func termsButton(_ sender: UISwitch) {
        if (sender.isOn == false)
        {
            signupButton.isEnabled = false
        }
        else{
            signupButton.isEnabled = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        fullnameText.resignFirstResponder()
        return(true)
    }
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}


class SigninViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.layer.cornerRadius = emailText.frame.size.height/2
        emailText.layer.borderWidth = 1.5
        emailText.layer.borderColor = UIColor.rgb(r: 46, g: 213, b: 115).cgColor
        emailText.clipsToBounds = true
        
        passwordText.layer.cornerRadius = passwordText.frame.size.height/2
        passwordText.layer.borderWidth = 1.5
        passwordText.layer.borderColor = UIColor.rgb(r: 46, g: 213, b: 115).cgColor
        passwordText.clipsToBounds = true
        
        emailText.delegate = self
        passwordText.delegate = self
    }
    @IBAction func loginClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
         
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again")
                }
                else {
                    self.performSegue(withIdentifier: "toTaskVC", sender: nil)
                }
            }
            
        }
        else{
            self.makeAlert(titleInput: "Error!", messageInput: "Kullanıcı adı veya Şifre hatalı/boş")
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return(true)
    }
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
