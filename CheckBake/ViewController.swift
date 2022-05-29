//
//  ViewController.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 27/04/22.
//

import UIKit
import CoreData

var forDashboardToday: [NSManagedObject] = []
var forDashboardScheduled: [NSManagedObject] = []
var forDashboardPast: [NSManagedObject] = []

class ViewController: UIViewController {

    @IBOutlet weak var dashboardAllOutlet: UILabel!
    @IBOutlet weak var dashboardTodayOutlet: UILabel!
    @IBOutlet weak var dashboardScheduledOutlet: UILabel!
    @IBOutlet weak var dashboardPastOutlet: UILabel!
    
    @IBOutlet weak var allRoundedCorner: UIView!
    @IBOutlet weak var todayRoundedCorner: UIView!
    @IBOutlet weak var scheduledRoundedCorner: UIView!
    @IBOutlet weak var pastRoundedCorner: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allRoundedCorner.layer.cornerRadius = 15
        allRoundedCorner.layer.masksToBounds = true
        todayRoundedCorner.layer.cornerRadius = 15
        todayRoundedCorner.layer.masksToBounds = true
        scheduledRoundedCorner.layer.cornerRadius = 15
        scheduledRoundedCorner.layer.masksToBounds = true
        pastRoundedCorner.layer.cornerRadius = 15
        pastRoundedCorner.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //show all
        let all: Int = sortedList.count
        self.dashboardAllOutlet.text = String(all)
        
        
        //fetch today
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Order")
        do{
            let predicateToday = NSPredicate(format: "date >= %@ && date <= %@", Calendar.current.startOfDay(for: Date()) as CVarArg, Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)
            request.predicate = predicateToday

            forDashboardToday = try context.fetch(request)
        } catch {print( "fetch failed")}
        
        //show today
        let today: Int = forDashboardToday.count
        self.dashboardTodayOutlet.text = String(today)
        
        
        //fetch scheduled
        do{
            let predicateToday = NSPredicate(format: "date > %@", Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)
            request.predicate = predicateToday

            forDashboardScheduled = try context.fetch(request)
        } catch {print( "fetch failed")}
        
        //show scheduled
        let scheduled: Int = forDashboardScheduled.count
        self.dashboardScheduledOutlet.text = String(scheduled)
        
        
        //fetch past
        do{
            let predicateToday = NSPredicate(format: "date < %@", Calendar.current.startOfDay(for: Date()) as CVarArg)
            request.predicate = predicateToday

            forDashboardPast = try context.fetch(request)
        } catch {print( "fetch failed")}
        
        //show past
        let past: Int = forDashboardPast.count
        self.dashboardPastOutlet.text = String(past)
    }

}

