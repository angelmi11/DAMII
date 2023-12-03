//
//  CreateCategoryViewController.swift
//  DAMII
//
//  Created by DAMII on 2/12/23.
//

import UIKit
import CoreData

class CreateCategoryViewController: UIViewController {

    @IBOutlet weak var descrip: UITextField!
    @IBOutlet weak var name: UITextField!
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DAMII")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func createCategory() {
        let category = Category(context: managedContext)
        category.name = name.text
        category.descrip = descrip.text

        do {
            try managedContext.save()
            print("Category created successfully.")
            navigateToCategoryListViewController()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func navigateToCategoryListViewController() {
        if let categoryListVC = storyboard?.instantiateViewController(withIdentifier: "listCategory") as? CategoryListViewController {
            navigationController?.pushViewController(categoryListVC, animated: true)
        }
    }

    @IBAction func btnCategory(_ sender: Any) {
        createCategory()
    }
   

}
