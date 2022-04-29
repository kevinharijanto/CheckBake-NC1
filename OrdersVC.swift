//
//  OrdersViewController.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 27/04/22.
//

import UIKit
import CoreData

var ordersList = [Order]()

var sortedList: [NSManagedObject] = []

var rowSelected: Int?

class OrdersVC: UIViewController {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerImageView = UIImageView.init()
        headerImageView.image = UIImage(named: "image")
        self.tableView.tableHeaderView = headerImageView
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        do{
            let sort = NSSortDescriptor(key:"date", ascending: true)
            request.sortDescriptors = [sort]

            let results = try context.fetch(request) as NSArray
                for result in results{
                    let order = result as! Order
                    sortedList.append(order)
                }
        } catch {print( "fetch failed")}
        
        if sortedList.count == 0 {
            tableView.setNoDataPlaceholder()
        } else{
            tableView.removeNoDataPlaceholder()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("lalala")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if sortedList.count == 0 {
            tableView.setNoDataPlaceholder()
        } else{
            tableView.removeNoDataPlaceholder()
        }
    }
    
    @IBAction func unwindFromSave(segue: UIStoryboardSegue){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Order")
        do{
            let sort = NSSortDescriptor(key:"date", ascending: true)
            request.sortDescriptors = [sort]

            sortedList = try context.fetch(request)
        } catch {print( "fetch failed")}
        
        tableView.reloadData()
        
        if sortedList.count == 0 {
            tableView.setNoDataPlaceholder()
        } else{
            tableView.removeNoDataPlaceholder()
        }
    }
    
    @IBAction func unwindFromDelete(segue: UIStoryboardSegue){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Order")
        do{
            let sort = NSSortDescriptor(key:"date", ascending: true)
            request.sortDescriptors = [sort]

            sortedList = try context.fetch(request)
        } catch {print( "fetch failed")}
        
        tableView.reloadData()
    }

}

extension UITableView{
    func setNoDataPlaceholder() {
        //munculin image
        let bgImage = UIImage(named:"image2")
        let image = UIImageView(image: bgImage)
        image.contentMode = .scaleAspectFit
        //munculin teks
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = "No Data."
        label.sizeToFit()
        

        self.isScrollEnabled = false
        self.backgroundView = image
        self.separatorStyle = .none
        }
}

extension UITableView {
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

// jumlah
extension OrdersVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ordersList.count
        return sortedList.count
    }
    
//teks apa
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ordersCell = tableView.dequeueReusableCell(withIdentifier: "ordersCellID", for: indexPath) as! OrdersCell
        
        
        let thisOrders = sortedList[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: thisOrders.value(forKeyPath: "date") as! Date)
        
        ordersCell.dateLabel.text = dateString
        ordersCell.titleLabel.text = thisOrders.value(forKeyPath: "title") as? String
        
        return ordersCell
    }
}

extension OrdersVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderTapItem") as? OrderTapItemVC
        
        rowSelected = indexPath.row
        
        let tapOrders = sortedList[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: tapOrders.value(forKeyPath: "date") as! Date)
        
        vc?.TapItemTitle = (tapOrders.value(forKeyPath: "title") as? String)!
        vc?.TapItemDate = dateString
        vc?.TapItemDesc = (tapOrders.value(forKeyPath: "desc") as? String)!
        vc?.rowSelected = rowSelected
        
        // change view & deselect
        self.navigationController?.pushViewController(vc!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




