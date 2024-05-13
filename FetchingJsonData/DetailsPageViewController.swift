//
//  DetailsPageViewController.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 29/04/24.
//

import UIKit

class DetailsPageViewController: UIViewController {

    @IBOutlet weak var donutImage: UIImageView!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var minusImage: UIImageView!
    @IBOutlet weak var itemTF: UITextField!
    @IBOutlet weak var plusImage: UIImageView!
    @IBOutlet weak var toppingsPicker: UIPickerView!
    
    var selectedImage: String?
    var individualPrice: String?
    var individualDescription: String?
    var minus: String?
    var plus: String?
    var itemCount: Int?
    var pictures = [String]()
    let toppings = ["None", "Glazed", "Sugar", "Powdered Sugar", "Chocolate with Sprinkles", "Chocolate", "Maple"]
    var topping: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        toppingsPicker.delegate = self
        toppingsPicker.dataSource = self
        
        shareTapped()
        itemCount = 1
        
        let minusTapGesture = UITapGestureRecognizer(target: self, action: #selector(minusImageTapped(gesture:)))
        minusImage.addGestureRecognizer(minusTapGesture)
        minusImage.isUserInteractionEnabled = true
        
        let plusTapGesture = UITapGestureRecognizer(target: self, action: #selector(plusImageTapped(gesture:)))
        plusImage.addGestureRecognizer(plusTapGesture)
        plusImage.isUserInteractionEnabled = true
        
        let items = ["regular_donut", "chocolate_donut", "blueberry_donut", "devils_food_donut"]
//        let image = ["minus", "plus"]
        
        for item in items {
            if item.hasSuffix("donut"){
                pictures.append(item)
            }
        }
        print(pictures)
        
        if let imageToLoad = selectedImage {
            donutImage.image = UIImage(named: imageToLoad)
        }
        
        if let price = individualPrice {
            priceTF.text = price
        }
        
        if let description = individualDescription {
            descriptionTF.text = description
        }
        
        if let minusIcon = minus {
            minusImage.image = UIImage(named: minusIcon)
        }
        
        if let plusIcon = plus {
            plusImage.image = UIImage(named: plusIcon)
        }
    }
    
    @objc func shareTapped() {
        guard let image = donutImage.image?.jpegData(compressionQuality: 0.8) else {
            print("Image not found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @IBAction func onClick(_ sender: Any) {
        guard let price = priceTF.text,
              let item = itemTF.text,
              let intPrice = Int(price),
              let intItem = Int(item) else {
                return
            }
            let result = intPrice * intItem
            
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Order") as? OrderViewController {
            vc.individualPrice = "Rs. \(String(result))"
            vc.toppings = topping
//            vc.selectedImage = pictures[IndexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func minusImageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            if let item = itemCount {
                itemTF.text = String(item)
            }
            if itemCount ?? 1 <= 1{
                itemCount = 1
            }
            else{
                itemCount! -= 1
            }
        }
    }
    
    @objc func plusImageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            if let item = itemCount {
                itemTF.text = String(item)
            }
            itemCount! += 1
        }
    }
}

extension DetailsPageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return toppings.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return toppings[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        topping = toppings[row]
    }
}
