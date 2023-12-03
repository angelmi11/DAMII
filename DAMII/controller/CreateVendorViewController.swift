import UIKit
import CoreData

class CreateVendorViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!

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
    }

   
    @IBAction func btnSaveVendor(_ sender: UIButton) {
        if let name = name.text, !name.isEmpty,
           let lastName = lastName.text, !lastName.isEmpty,
           let email = email.text, !email.isEmpty,
           let address = address.text, !address.isEmpty,
           let phone = phone.text, !phone.isEmpty {

            createVendor(name: name, lastName: lastName, email: email, address: address, phone: phone)
            navigationController?.popViewController(animated: true)
        } else {
            // Muestra una alerta o realiza alguna acción en caso de que falten datos
            showAlert(message: "Todos los campos son obligatorios")
        }
    }
   

    func createVendor(name: String, lastName: String, email: String, address: String, phone: String) {
        let vendor = Vendor(context: managedContext)
        vendor.name = name
        vendor.lastName = lastName
        vendor.email = email
        vendor.address = address
        vendor.phone = phone

        do {
            try managedContext.save()
            print("Proveedor creado exitosamente.")
            navigateToVendorListViewController()
        } catch let error as NSError {
            print("Error al guardar el proveedor. \(error), \(error.userInfo)")
        }
    }
    
    func navigateToVendorListViewController() {
        if let vendorListVC = storyboard?.instantiateViewController(withIdentifier: "listVendor") as? VendorListViewController {
            navigationController?.pushViewController(vendorListVC, animated: true)
        }
    }


    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
