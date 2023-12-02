import UIKit
import CoreData

class CreateProductViewController: UIViewController {
   
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var categoryPick: UIPickerView!
    @IBOutlet weak var descrip: UITextField!

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

        // Configurar el dataSource y delegate del pickerView
        

        // Cargar las categorías desde CoreData
       
    }

    func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try managedContext.fetch(fetchRequest)
            categoryPick.reloadAllComponents()
        } catch let error as NSError {
            print("Could not fetch categories. \(error), \(error.userInfo)")
        }
    }
    

    @IBAction func btnSaveProduct(_ sender: Any) {
        guard let productName = name.text, let productPriceText = price.text, let productDescription = descrip.text else {
               // Manejar el caso donde los campos requeridos están vacíos
               return
           }

/*guard let selectedCategory = selectedCategory else {
               // Manejar el caso donde no se ha seleccionado ninguna categoría
               return
           }*/

           // Convertir el precio a Float
        let productPrice = NSDecimalNumber(string: productPriceText).floatValue

        // Verificar si el valor de productPrice es un número válido
        if !productPrice.isNaN && !productPrice.isInfinite {
            // El precio es un número válido, puedes usar productPrice
        } else {
            // Manejar el caso donde el precio no es un número válido
            return
        }

            // Crear una instancia de la entidad Product y establecer sus propiedades
            let newProduct = Product(context: managedContext)
            newProduct.name = productName
            newProduct.price = productPrice
            newProduct.descrip = productDescription

            // Guardar el contexto
            do {
                try managedContext.save()
                print("Producto guardado exitosamente.")
                // Puedes realizar otras acciones después de guardar el producto, como regresar a la pantalla anterior
            } catch let error as NSError {
                print("Error al guardar el producto. \(error), \(error.userInfo)")
            }
    }

    // Implementar las funciones requeridas por UIPickerViewDataSource y UIPickerViewDelegate
    

 
}
