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
            navigateToLoginViewController()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func navigateToLoginViewController() {
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginForm") as? LoginViewController {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }

    @IBAction func btnRegister(_ sender: Any) {
        createUser()
    }
}
