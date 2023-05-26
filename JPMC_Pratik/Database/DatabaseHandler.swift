//
//  DatabaseHandler.swift
//  JPMC_Pratik
//
//  Created by Pratik Patil on 23/05/23.
//

import Foundation
import CoreData
import UIKit

// A Class to handle all the databasse related stuff.
class DatabaseHandler {
    
    static let shared = DatabaseHandler() // Created the shared intatnce to make it as a Singleton Class.
    // Creating View Context
    private var viewContext : NSManagedObjectContext
    
    init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // Generic function to add any data to Core Data
    func addToCoreData<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
//    To clear all the planet entity data from Core Data Database
    func clearData() {
        do {
            let array = fetchFromCoreData(Planet.self) // Fetching data
            for planet in array {
                viewContext.delete(planet) // Deleting each content
            }
            saveToCoreData() // Saving the changes.
        }
    }
    
    // Safely save the data to Core Data Database
    func saveToCoreData() {
        do{
            try viewContext.save()
        }catch{
            debugPrint(error.localizedDescription)
        }
    }
    
    // Fetch the data from Core Data Database
    func fetchFromCoreData<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
}
