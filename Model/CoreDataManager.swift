//
//  CoreDataManager.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 03.02.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedWorldClock = CoreDataManager(modelName: "WorldClock")
    static let sharedAlarms = CoreDataManager(modelName: "Alarm")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load() {
        persistentContainer.loadPersistentStores { descriptiom, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error while saving \(error.localizedDescription)")
            }
        }
    }
    
}

extension CoreDataManager {
    
    func createWorldClock() -> WorldClock {
        let newClock = WorldClock(context: viewContext)
        newClock.dateAdded = Date()
        newClock.city = ""
        save()
        return newClock
    }

    func fetchWorldClocks() -> [WorldClock] {
        let request: NSFetchRequest<WorldClock> = WorldClock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \WorldClock.dateAdded, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return (try? viewContext.fetch(request)) ?? []
    }

    func deleteWorldClock(_ worldClock: WorldClock) {
        viewContext.delete(worldClock)
        save()
    }
    
}
