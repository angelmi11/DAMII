import UIKit
import CoreData

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var userTable: UITableView!
    var users: [User] = []
    

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
        userTable.dataSource = self
        userTable.delegate = self

        // Cargar los usuarios y actualizar la tabla
        loadUsers()
    }

    func loadUsers() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        print("GOLAS")
        do {
            users = try managedContext.fetch(fetchRequest)
            userTable.reloadData()
            
            // Imprime los usuarios para verificar los valores
            for user in users {
                print("User: \(user.name ?? "No Name"), Email: \(user.email ?? "No Email")")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCel", for: indexPath)
        
        let user = users[indexPath.row]
        print(user.name)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email

        return cell
    }
    
    // Agregar acciones de edición (eliminar y editar) a las celdas
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { [weak self] (_, indexPath) in
            self?.editUser(at: indexPath)
        }
        editAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { [weak self] (_, indexPath) in
            self?.deleteUser(at: indexPath)
        }
        
        return [deleteAction, editAction]
    }
    
    // Función para manejar la acción de edición de una celda
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Esto es necesario para evitar un error
    }
    
    // Función para editar un usuario
    func editUser(at indexPath: IndexPath) {
        // Implementa la lógica para editar el usuario aquí
        // Puedes abrir un nuevo controlador de vista para la edición o realizar la edición directamente en la celda
    }
    
    // Función para eliminar un usuario
    func deleteUser(at indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        do {
            managedContext.delete(user)
            try managedContext.save()
            
            // Actualizar la lista de usuarios después de eliminar
            loadUsers()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
