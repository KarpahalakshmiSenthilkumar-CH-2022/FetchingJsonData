//
//  ViewController.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 17/04/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var postTf: UILabel!
    
    var bakery: Bakery?
    var pictures = [String]()
    var minusIcon: String?
    var plusIcon:String?
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "BakeryCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .lightGray
        
        //        fetchData { (dict, error) in
        //            debugPrint(dict!)
        //            DispatchQueue.main.async {
        //                self.postTf.text = dict?.posts[0].title
        //            }
        //        }
        
        loadData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let items = ["regular_donut", "chocolate_donut", "blueberry_donut", "devils_food_donut"]
//        let image = ["minus", "plus"]
        
        for item in items {
            if item.hasSuffix("donut"){
                pictures.append(item)
            }
        }
        print(pictures)
        
        minusIcon = "minus"
        plusIcon = "plus"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bakery?.bakery.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(bakery?.bakery[section].name ?? "") \(bakery?.bakery[section].type ?? "")"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = bakery {
            return (result.bakery[section].batters?.batter.count ?? 0) // + result.bakery[section].topping.count
        }
        return 0
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Cell clicked")
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bakeryList = bakery?.bakery[indexPath.section].batters
        let toppingsList = bakery?.bakery[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BakeryCell", for: indexPath)
        
        if indexPath.row < bakeryList?.batter.count ?? 0 {
            cell.textLabel?.text = bakeryList?.batter[indexPath.row].type
        }
        else{
            cell.textLabel?.text = toppingsList?.topping[indexPath.row /* - (bakeryList?.batter.count ?? 0) */ ].type
        }
        navigationItem.title = "Sofy Donut"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let price = bakery?.bakery[indexPath.section].batters
        let description = bakery?.bakery[indexPath.section].batters
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailsPageViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.individualPrice = price?.batter[indexPath.row].price
            vc.individualDescription = description?.batter[indexPath.row].description
            vc.minus = minusIcon
            vc.plus = plusIcon
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let bakeryData = try Data(contentsOf: url)
            bakery = try JSONDecoder().decode(Bakery.self, from: bakeryData)
            
            if let result = bakery {
                print(result)
            }
            else {
                print("Failed to parse data")
            }
        } catch {
            print(error)
        }
    }
}
