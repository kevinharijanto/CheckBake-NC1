//
//  OrderTapItem.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 28/04/22.
//

import UIKit
import CoreData

class OrderTapItemVC: UIViewController {

    @IBOutlet weak var titleTapOutlet: UILabel!
    @IBOutlet weak var dateTapOutlet: UILabel!
    @IBOutlet weak var descTapOutlet: UITextView!
    
    var TapItemTitle = ""
    var TapItemDate = ""
    var TapItemDesc = ""
    
    var rowSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTapOutlet.text = TapItemTitle
        dateTapOutlet.text = TapItemDate
        descTapOutlet.text = TapItemDesc
    }
    
    @IBAction func deleteOrder(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        do{
            let deletingOrder = sortedList[rowSelected!]
            context.delete(deletingOrder)
            
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {print( "fetch failed")}
        
    }
    //edit button
//    @IBAction func editFromTapItem(_ sender: Any) {
//        if let destSeg = segue.destination as? OrdersDetailVC{
//            destSeg.rowSelected =  rowSelected
//        }
//    }
    
    
}
