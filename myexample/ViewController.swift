//
//  ViewController.swift
//  myexample
//
//  Created by Luis Humberto Carlin Vargas on 18/10/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var listProducts: [Product] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let arrayNumbers = [1, 2, 3, 4, 5, 6]
        let result = totalEvenNumbers(in: arrayNumbers)
        print("Total: \(result)")
        getProducts()
    }
    
    func totalEvenNumbers(in arrayNumbers: [Int]) -> Int {
        var total = 0
        for item in arrayNumbers {
            if item % 2 == 0 {
                total += item
            }
        }
        return total
    }
    
    
    func getProducts() {
            
            let apiUrlString = "https://fakestoreapi.com/products"

            guard let apiUrl = URL(string: apiUrlString) else {
                print("Invalid URL")
                return
            }

            
            let task = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {

                    self.listProducts = try JSONDecoder().decode([Product].self, from: data)
                    
                    let context = CoreDataManager.shared.context
                    for productData in self.listProducts {
                        let product = ProductsEntity(context: context)
                        product.title = productData.title
                        product.price = productData.price
                    }

                    do {
                        try context.save()
                    } catch {
                        print("Failed to save products to Core Data: \(error)")
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listProducts.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = listProducts[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    


}

