//
//  RegisterViewController.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 30/04/24.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var BusinessTF: UITextField!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    
    var iconClick = true
    let defaultBorderColor = UIColor.lightGray.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
    }
    
    func resetForm(){
        SubmitButton.isEnabled = false
        
        NameTF?.text = ""
        BusinessTF?.text = ""
        PhoneTF?.text = ""
        EmailTF?.text = ""
        PasswordTF?.text = ""
                
        NameTF?.layer.borderColor = defaultBorderColor
        BusinessTF?.layer.borderColor = defaultBorderColor
        PhoneTF?.layer.borderColor = defaultBorderColor
        EmailTF?.layer.borderColor = defaultBorderColor
        PasswordTF?.layer.borderColor = defaultBorderColor
        
        NameTF?.layer.borderWidth = 1.0
        BusinessTF?.layer.borderWidth = 1.0
        PhoneTF?.layer.borderWidth = 1.0
        EmailTF?.layer.borderWidth = 1.0
        PasswordTF?.layer.borderWidth = 1.0
        
        NameTF?.layer.cornerRadius = 6.0
        BusinessTF?.layer.cornerRadius = 6.0
        PhoneTF?.layer.cornerRadius = 6.0
        EmailTF?.layer.cornerRadius = 6.0
        PasswordTF?.layer.cornerRadius = 6.0
    }
    
    @IBAction func NameChanged(_ sender: Any) {
        if let name = NameTF.text
        {
            if let error = invalidName(name){
                NSLog(error)
            }
        }
        validateForm()
    }
    
    func invalidName(_ value:String) -> String?{
        let regularExpression = "[a-zA-Z]{4,18}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            NameTF.layer.borderColor = UIColor.red.cgColor
            return "Invalid Name"
        }
        NameTF.layer.borderColor = defaultBorderColor
        return "Valid Name"
    }
    
    @IBAction func BussinessNameChanged(_ sender: Any) {
        if let businessName = BusinessTF.text
        {
            if let error = invalidBussinessName(businessName){
                NSLog(error)
            }
        }
        validateForm()
    }
    
    func invalidBussinessName(_ value:String) -> String?{
        let regularExpression = "^[1-9][0-9]{5}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            BusinessTF.layer.borderColor = UIColor.red.cgColor
            return "Invalid Bussiness Name"
        }
        BusinessTF.layer.borderColor = defaultBorderColor
        return "Valid Bussiness Name"
    }
    
    @IBAction func PhoneChanged(_ sender: Any) {
        if let phone = PhoneTF.text
        {
            if let error = invalidPhone(phone){
                NSLog(error)
            }
        }
        validateForm()
    }
    
    func invalidPhone(_ value:String) -> String?{
        let regularExpression = "[7-9]{1}+[0-9]{9}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            PhoneTF.layer.borderColor = UIColor.red.cgColor
            return "Invalid Phone Number"
        }
        PhoneTF.layer.borderColor = defaultBorderColor
        return "Valid Phone Number"
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
        if ((NameTF.text?.isEmpty)==true) || ((BusinessTF.text?.isEmpty)==true) || ((PhoneTF.text?.isEmpty)==true) || ((EmailTF.text?.isEmpty)==true) || ((PasswordTF.text?.isEmpty)==true)
        {
            SubmitButton.isEnabled = false
        }
        else
        {
            SubmitButton.isEnabled = true
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
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error!.localizedDescription)")
                return
            }
        }
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "goToLoginPage") as? LoginViewController {
            destinationVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
