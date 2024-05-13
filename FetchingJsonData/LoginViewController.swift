//
//  LoginViewController.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 30/04/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var SigninButton: UIButton!
    var iconClick = true

    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
    }
    
    func resetForm(){
        SigninButton?.isEnabled = false
        
        EmailTF?.text = ""
        PasswordTF?.text = ""
        
        EmailTF?.layer.borderColor = UIColor.lightGray.cgColor
        PasswordTF?.layer.borderColor = UIColor.lightGray.cgColor
        
        EmailTF?.layer.borderWidth = 1.0
        PasswordTF?.layer.borderWidth = 1.0
        
        EmailTF?.layer.cornerRadius = 6.0
        PasswordTF?.layer.cornerRadius = 6.0
    }
    
    @IBAction func EmailChanged(_ sender: Any) {
        if let email = EmailTF.text
        {
            if let error = invalidEmail(email){
                NSLog(error)
            }
        }
        validateForm()
    }
    
    func invalidEmail(_ value:String) -> String?{
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            EmailTF.layer.borderColor = UIColor.red.cgColor
            return "Invalid Email Address"
        }
        EmailTF.layer.borderColor = UIColor.lightGray.cgColor
        return "Valid Email Address"
    }
    
    @IBAction func PasswordChanged(_ sender: Any) {
        if let password = PasswordTF.text
        {
            if let error = invalidPassword(password){
                NSLog(error)
            }
        }
        validateForm()
    }
    
    func invalidPassword(_ value:String) -> String?{
        if value.count<8{
            PasswordTF.layer.borderColor = UIColor.red.cgColor
            return "Password must have atleast 8 characters"
        }
        if containsDigit(value){
            PasswordTF.layer.borderColor = UIColor.red.cgColor
            return "Password must contain atleast 1 digit"
        }
        if containsLowercase(value){
            PasswordTF.layer.borderColor = UIColor.red.cgColor
            return "Password must contain atleast 1 lowercase character"
        }
        if containsUppercase(value){
            PasswordTF.layer.borderColor = UIColor.red.cgColor
            return "Password must contain atleast 1 uppercase character"
        }
        PasswordTF.layer.borderColor = UIColor.lightGray.cgColor
        return "Valid Password"
    }
    
    func containsDigit(_ value:String) -> Bool{
        let regularExpression = ".*[0-9].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowercase(_ value:String) -> Bool{
        let regularExpression = ".*[a-z].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUppercase(_ value:String) -> Bool{
        let regularExpression = ".*[A-Z].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func validateForm(){
        if ((EmailTF.text?.isEmpty)==true) || ((PasswordTF.text?.isEmpty)==true)
        {
            SigninButton.isEnabled = false
        }
        else
        {
            SigninButton.isEnabled = true
        }
    }
    
    @IBAction func iconAction(_ sender: Any) {
        if iconClick {
                PasswordTF.isSecureTextEntry = false
            } else {
                PasswordTF.isSecureTextEntry = true
            }
            iconClick = !iconClick
    }
    
    @IBAction func ButtonAction(_ sender: Any) {
        guard let email = EmailTF.text, !email.isEmpty, let password = PasswordTF.text, !password.isEmpty else {
            print("Missing fields")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let self = self else { return }
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "donutsList") as? ViewController {
                destinationVC.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(destinationVC, animated: true)
            }
        })
        resetForm()
    }
}
