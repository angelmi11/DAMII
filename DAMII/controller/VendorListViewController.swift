import UIKit
import CoreData

class VendorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var vendorTable: UITableView!
    @IBOutlet weak var btnCreateVendor: UIButton!
    var vendors: [Vendor] = []
    
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

        // Configurar el dataSource y delegate de la tableView
        vendorTable.dataSource = self
        vendorTable.delegate = self

        // Cargar los vendedores y actualizar la tabla
        loadVendors()
    }

    
    func loadVendors() {
        let fetchRequest: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        do {
            vendors = try managedContext.fetch(fetchRequest)
            vendorTable.reloadData()

            // Imprime los vendedores para verificar los valores
            for vendor in vendors {
                print("Vendor: \(vendor.name ?? "No Name"), Descrip: \(vendor.email ?? "No Email")")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vendorCel", for: indexPath)

        let vendor = vendors[indexPath.row]
        cell.textLabel?.text = vendor.name
        cell.detailTextLabel?.text = vendor.email

        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { [weak self] (_, indexPath) in
            // Acción para editar
            self?.editVendor(at: indexPath)
        }

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { [weak self] (_, indexPath) in
            // Acción para eliminar
            self?.deleteVendor(at: indexPath)
        }

        return [editAction, deleteAction]
    }

    func editVendor(at indexPath: IndexPath) {
        // Implementa la lógica para editar la categoría en el índice indexPath
    }

    
    func deleteVendor(at indexPath: IndexPath) {
        let categoryToDelete = vendors[indexPath.row]
        let alert = UIAlertController(title: "Confirmar Eliminación", message: "¿Estás seguro de que quieres eliminar este proveedor?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { [weak self] _ in
            self?.managedContext.delete(categoryToDelete)
            do {
                try self?.managedContext.save()

                self?.loadVendors()
            } catch let error as NSError {
                print("Error al guardar cambios después de la eliminación: \(error), \(error.userInfo)")
            }
        }))

        present(alert, animated: true, completion: nil)
    }
        
        
       

    @IBAction func btnCreateVendor(_ sender: UIButton) {
        navigateToCreateVendorViewController()
    }
    
    func navigateToCreateVendorViewController() {
        if let vendorVC = storyboard?.instantiateViewController(withIdentifier: "vendor") as? CreateVendorViewController {
            navigationController?.pushViewController(vendorVC, animated: true)
        }
    }
}
