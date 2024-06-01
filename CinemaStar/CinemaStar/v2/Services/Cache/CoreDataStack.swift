//
//  CoreDataStack.swift
//  CinemaStar
//
//  Created by Kate Volkova on 31.05.24.
//

import CoreData
import Foundation

/// Сервис инициализирующий CoreData context и публичное апи
final class CoreDataStack {
    static let shared = CoreDataStack()
    private let persistentContainerName = "NetReqCachingDataModel"

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}

// MARK: - Публичное апи сохранения/получения данных из хранилища

extension CoreDataStack {
    func saveContext() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nsError = error as NSError
            NSLog("Unresolved error saving context: \(nsError), \(nsError.userInfo)")
        }
    }

    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
