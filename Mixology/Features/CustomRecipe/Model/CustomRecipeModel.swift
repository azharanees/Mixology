//
//  CustomRecipeModel.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import Foundation
import CoreData

class CustomRecipeModel: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var desc: String
    @NSManaged var strength: String
    @NSManaged var difficulty: String
    @NSManaged var ingredients: String
    @NSManaged var image: String
    
                           
    convenience init(context: NSManagedObjectContext) {
        self.init(context: context)
    }
}
