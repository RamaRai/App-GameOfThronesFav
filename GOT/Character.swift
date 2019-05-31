//
//  Character.swift
//  Game Of Thrones Favourites
//  Reading data from Json downloaded and saved as file in the bundle source.json
//  Keywords Image, Table View, Like, record selection for further details
//  CoreData - create record and delete record
//
//  Created by Rama Rai on 2019-05-20.
//  Copyright © 2019 Rama Rai All rights reserved.
//

import Foundation
import CoreData


class Character {
    
    var character_name : String?
    var character_house : String?
    var character_image : String?
    var isFavorait : Bool?
    

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GOT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //Constructor
    init() {
        
    }
    
    //Deleting record from database
    func deleteDB(dbCharArray : [DBCharacter])  {
        for item in dbCharArray {
            
        persistentContainer.viewContext.delete(item)
        }
        saveContext()
        }
    
    //Constructors with data
    init(name : String? , house : String? , image : String?,Favorate : Bool) {
        self.character_name = name
        self.character_house = house
        self.character_image = image
        self.isFavorait = Favorate
        
    }
    
    //Creating fav list as saving record to CoreData
  func saveToDB(c : Character)  {
    let newCharacter = DBCharacter(context: persistentContainer.viewContext)
    
    newCharacter.name = c.character_name
    newCharacter.house = c.character_house
    newCharacter.image = c.character_image
    saveContext()
    
    }
    
    //Looking for  duplicate record
    
    func checkIfInFavorait(name : String) -> Bool {
        let fetch : NSFetchRequest = DBCharacter.fetchRequest()
        var inDB = false
        let predicate : NSPredicate = NSPredicate.init(format: "name MATCHES %@", name)
        fetch.predicate = predicate
        do{
           let favoraitCharacters = try persistentContainer.viewContext.fetch(fetch)
            if favoraitCharacters.count == 1 {inDB = true}
            
        }catch{
            
        }
        
        return inDB
        
    }
    
    
    //Fetching records from CoreData to array
    
    func getFavoraitCharacters() -> [DBCharacter] {
        let fetch : NSFetchRequest = DBCharacter.fetchRequest()
        var favoraitCharacters = [DBCharacter]()
        
        do{
        favoraitCharacters = try persistentContainer.viewContext.fetch(fetch)
        }catch{
            
        }
        
        return favoraitCharacters
        
    }
}
