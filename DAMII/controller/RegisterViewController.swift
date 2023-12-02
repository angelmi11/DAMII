import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

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

    func createUser() {
        let user = User(context: managedContext)
        user.name = name.text
        user.lastName = lastName.text
        user.email = email.text
        user.password = password.text

        do {
            try managedContext.save()
            print("User created successfully.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchUsers() -> [User]? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try managedContext.fetch(fetchRequest)
            return users
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }

    func updateUser(user: User, newName: String) {
        user.name = newName

        do {
            try managedContext.save()
            print("User updated successfully.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func deleteUser(user: User) {
        managedContext.delete(user)

        do {
            try managedContext.save()
            print("User deleted successfully.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    @IBAction func btnRegister(_ sender: Any) {
        createUser()
    }
}
