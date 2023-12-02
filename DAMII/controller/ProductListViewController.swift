//
//  ProductListViewController.swift
//  DAMII
//
//  Created by DAMII on 2/12/23.
//

import UIKit

class ProductListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var productTable: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnCreateProduct(_ sender: Any) {
        navigateToCreateProductViewController()
    }
    
    func navigateToCreateProductViewController() {
        if let vendorVC = storyboard?.instantiateViewController(withIdentifier: "product") as? CreateProductViewController {
            navigationController?.pushViewController(vendorVC, animated: true)
        }
    }
}
