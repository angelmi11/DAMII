import UIKit
import CoreData

class CategoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryTable: UITableView!
    var categories: [Category] = []

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
        categoryTable.dataSource = self
        categoryTable.delegate = self

        // Cargar las categorías y actualizar la tabla
        loadCategories()
    }

    @IBAction func btnCreateCat(_ sender: UIButton) {
        navigateToCreateCategoryViewController()
    }

    func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try managedContext.fetch(fetchRequest)
            categoryTable.reloadData()

            // Imprime las categorías para verificar los valores
            for category in categories {
                print("Category: \(category.name ?? "No Name"), Descrip: \(category.descrip ?? "No Description")")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCel", for: indexPath)

        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = category.descrip

        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { [weak self] (_, indexPath) in
            // Acción para editar
            self?.editCategory(at: indexPath)
        }

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { [weak self] (_, indexPath) in
            // Acción para eliminar
            self?.deleteCategory(at: indexPath)
        }

        return [editAction, deleteAction]
    }

    func editCategory(at indexPath: IndexPath) {
        // Implementa la lógica para editar la categoría en el índice indexPath
    }

    func deleteCategory(at indexPath: IndexPath) {
        let categoryToDelete = categories[indexPath.row]
        let alert = UIAlertController(title: "Confirmar Eliminación", message: "¿Estás seguro de que quieres eliminar esta categoría?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { [weak self] _ in
            self?.managedContext.delete(categoryToDelete)
            do {
                try self?.managedContext.save()

                self?.loadCategories()
            } catch let error as NSError {
                print("Error al guardar cambios después de la eliminación: \(error), \(error.userInfo)")
            }
        }))

        present(alert, animated: true, completion: nil)
    }


    func navigateToCreateCategoryViewController() {
        if let categoryVC = storyboard?.instantiateViewController(withIdentifier: "category") as? CreateCategoryViewController {
            navigationController?.pushViewController(categoryVC, animated: true)
        }
    }
}
