import UIKit
import CoreData

class LoginViewController: UIViewController {

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

    @IBAction func btnLogin(_ sender: Any) {
        if let email = email.text, let password = password.text {
            if let user = fetchUser(email: email, password: password) {
                print("Login successful. Welcome, \(user.name ?? "User")!")
                // Aquí puedes navegar a la próxima pantalla o realizar otras acciones después del inicio de sesión exitoso.
                navigateToCatalogueViewController()
            } else {
                print("Invalid email or password. Please try again.")
                // Puedes mostrar un mensaje de error al usuario.
            }
        }
    }

    func fetchUser(email: String, password: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

        do {
            let users = try managedContext.fetch(fetchRequest)
            return users.first
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func navigateToCatalogueViewController() {
            if let catalogueVC = storyboard?.instantiateViewController(withIdentifier: "catalogue") as? CatalogueViewController {
                navigationController?.pushViewController(catalogueVC, animated: true)
            }
        }
}
