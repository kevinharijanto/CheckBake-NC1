//
//  Order+CoreDataProperties.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 27/04/22.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?

}

extension Order : Identifiable {

}
