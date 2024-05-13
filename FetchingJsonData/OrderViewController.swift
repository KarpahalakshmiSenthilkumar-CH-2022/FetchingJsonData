//
//  OrderViewController.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 07/05/24.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var toppingsTF: UITextField!
    @IBOutlet weak var address1TF: UITextField!
    @IBOutlet weak var address2TF: UITextField!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    let defaultBorderColor = UIColor.lightGray.cgColor
    var individualPrice: String?
    var selectedImage: String?
    var toppings:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetForm()
        
        if let price = individualPrice {
            priceTF.text = price
        }
        
        if let toppingsSelected = toppings {
            toppingsTF.text = toppingsSelected
        }
        
        if let imageToLoad = selectedImage {
            productImage.image = UIImage(named: imageToLoad)
        }
    }
    
    func resetForm(){
        placeOrderButton.isEnabled = false
        
        address1TF?.text = ""
        address2TF?.text = ""
        pincodeTF?.text = ""
        mobileNumberTF?.text = ""
                
        address1TF?.layer.borderColor = defaultBorderColor
        address2TF?.layer.borderColor = defaultBorderColor
        pincodeTF?.layer.borderColor = defaultBorderColor
        mobileNumberTF?.layer.borderColor = defaultBorderColor
        
        address1TF?.layer.borderWidth = 1.0
        address2TF?.layer.borderWidth = 1.0
        pincodeTF?.layer.borderWidth = 1.0
        mobileNumberTF?.layer.borderWidth = 1.0
        
        address1TF?.layer.cornerRadius = 6.0
        address2TF?.layer.cornerRadius = 6.0
        pincodeTF?.layer.cornerRadius = 6.0
        mobileNumberTF?.layer.cornerRadius = 6.0
    }
    
    @IBAction func address1Changed(_ sender: Any) {
        validateForm()
    }
    
    @IBAction func address2Changed(_ sender: Any) {
        validateForm()
    }
    
    @IBAction func pincodeChanged(_ sender: Any) {
        if let pincode = pincodeTF.text
        {
            if let error = invalidPincode(pincode){
                NSLog(error)
            }
        }
        validateForm()
    }
    
    func invalidPincode(_ value:String) -> String?{
        let regularExpression = "[0-9]{6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            mobileNumberTF.layer.borderColor = UIColor.red.cgColor
            return "Invalid Pincode"
        }
        mobileNumberTF.layer.borderColor = defaultBorderColor
        return "Valid Pincode"
    }
    
    @IBAction func mobileNumberChanged(_ sender: Any) {
        if let mobile = mobileNumberTF.text
        {
            if let error = invalidPhone(mobile){
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
            mobileNumberTF.layer.borderColor = UIColor.red.cgColor
            return "Invalid Phone Number"
        }
        mobileNumberTF.layer.borderColor = defaultBorderColor
        return "Valid Phone Number"
    }
    
    func validateForm(){
        if ((address1TF.text?.isEmpty)==true) || ((address2TF.text?.isEmpty)==true) || ((pincodeTF.text?.isEmpty)==true) || ((mobileNumberTF.text?.isEmpty)==true)
        {
            placeOrderButton.isEnabled = false
        }
        else
        {
            placeOrderButton.isEnabled = true
        }
    }
}
