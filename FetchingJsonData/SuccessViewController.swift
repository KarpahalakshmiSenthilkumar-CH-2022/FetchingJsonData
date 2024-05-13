//
//  SuccessViewController.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 08/05/24.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var successImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        do {
//            if let gifURL = Bundle.main.url(forResource: "success", withExtension: "gif") {
//                let imageData = try Data(contentsOf: gifURL)
//                successImage.image = UIImage(data: imageData)
//                print(imageData)
//            }
//        } catch {
//            print("Error loading image: \(error.localizedDescription)")
//        }
    }
}
