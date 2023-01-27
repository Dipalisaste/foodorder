//
//  OrderMeal+CoreDataProperties.swift
//  
//
//  Created by Felix-ITS015 on 29/10/1944 Saka.
//
//

import Foundation
import CoreData


extension OrderMeal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderMeal> {
        return NSFetchRequest<OrderMeal>(entityName: "OrderMeal")
    }

    @NSManaged public var address: String?
    @NSManaged public var mobnumber: Int64
    @NSManaged public var name: String?
    @NSManaged public var orderimg: NSData?
    @NSManaged public var ordername: String?
    @NSManaged public var quntity: Int64

}
