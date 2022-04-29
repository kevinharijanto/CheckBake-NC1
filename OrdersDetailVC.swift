//
//  OrdersDetailVC.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 27/04/22.
//

import UIKit
import CoreData

var arrayOrder = [String]()

class OrdersDetailVC: UIViewController {
    
    var rowSelected: Int?

    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        if(rowSelected == nil){
            let entity = NSEntityDescription.entity(forEntityName: "Order", in: context)
            let newOrders = Order(entity: entity!, insertInto: context)

            newOrders.title = titleField.text
            newOrders.desc = descField.text
            newOrders.date = dateField.date
            
            do {
                
                try context.save()
                sortedList.append(newOrders)
//                ordersList.append(newOrders)
                //lempar segue manual
                performSegue(withIdentifier: "goToOrdersList", sender: nil)
            } catch {
                print("context save error")
            }
        } //edit
//        else{
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//            do{
//                let results:NSArray = try context.fetch(request) as NSArray
//                for result in results{
//                    let order = result as! Order
//                    
//                    order.title = titleField.text
//                    order.desc = descField.text
//                    try context.save()
//                    performSegue(withIdentifier: "goToOrdersList", sender: nil)
//                    }
//                }
//            }
//            catch {
//                print("Fetch Failed")
//            }
//        }
    }
    
}
