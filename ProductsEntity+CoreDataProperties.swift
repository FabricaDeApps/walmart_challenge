//
//  ProductsEntity+CoreDataProperties.swift
//  myexample
//
//  Created by Luis Humberto Carlin Vargas on 18/10/23.
//
//

import Foundation
import CoreData


extension ProductsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsEntity> {
        return NSFetchRequest<ProductsEntity>(entityName: "ProductsEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Double

}

extension ProductsEntity : Identifiable {

}
