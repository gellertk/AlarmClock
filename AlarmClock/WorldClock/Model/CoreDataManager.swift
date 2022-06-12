//
//  CoreDataManager.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 03.02.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "WorldClock")
    
    private let persistentContainer: NSPersistentContainer
    private var viewContext: NSManagedObjectContext {
        
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load() {
        persistentContainer.loadPersistentStores { _ , error in
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
    
    func createWorldClock(_ city: String) -> WorldClock {
        let newClock = WorldClock(context: viewContext)
        newClock.dateAdded = Date()
        newClock.city = city
        newClock.hourDifference = Int16(Int.random(in: -12...12))
        save()
        
        return newClock
    }
    
    func loadWorldClock(_ city: String) {
        let newClock = WorldClock(context: viewContext)
        newClock.dateAdded = Date()
        newClock.city = city
        newClock.hourDifference = Int16(Int.random(in: -12...12))
        save()
    }
    
    func fetchWorldClocks() -> [WorldClock] {
        if UserDefaults.isFirstLaunch() {
            for city in WorldClock.defaultCities {
                loadWorldClock(city)
            }
        }
        
        let request: NSFetchRequest<WorldClock> = WorldClock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \WorldClock.dateAdded,
                                              ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteWorldClock(_ worldClock: WorldClock) {
        viewContext.delete(worldClock)
        save()
    }
    
}
