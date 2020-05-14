//
//  CoreDataUseCase.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataUseCase {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Google_contacts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context =  persistentContainer.viewContext
        if context.hasChanges{
            do {
                  try context.save()
              } catch {
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
        }
    }
}
