//
//  CoreDataManager.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 6.03.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import CoreData
struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistenceContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavouriteVenuesModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed \(err)")
            }
        })
        
        return container
        
    }()
    
    func fetchVenues() -> [Favourites] {
        let context = persistenceContainer.viewContext
        let fetchRequest = NSFetchRequest<Favourites>(entityName: "Favourites")
        do{
             let venues = try context.fetch(fetchRequest)
            return venues
        }catch let err {
            print(err)
            return []
        }
        
    }
   
}
