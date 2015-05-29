//
//  VestibularManager.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 25/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import CoreData
import UIKit

public class VestibularManager {
    static let sharedInstance:VestibularManager = VestibularManager()
    static let entityName:String = "Vestibular"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    private init(){}
    
    func newVestibular() -> Vestibular {
        return NSEntityDescription.insertNewObjectForEntityForName(VestibularManager.entityName, inManagedObjectContext: managedContext) as! Vestibular
    }
    
    func saveVestibular() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findVestibular() -> [Vestibular] {
        let fetchRequest = NSFetchRequest(entityName: VestibularManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Vestibular] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return [Vestibular]()
    }
    
    func findVestibularByName(nome: String) -> Vestibular {
        let predicate = NSPredicate(format: "nome == %@", nome)
        let fetchRequest = NSFetchRequest(entityName: VestibularManager.entityName)
        fetchRequest.predicate = predicate
        var error:NSError?
        
        let fetchedResult = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let result = fetchedResult as? [Vestibular] {
            return result[0]
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        return Vestibular()
    }
    
    func deleteVestibular(vestibular: Vestibular) {
        managedContext.delete(vestibular)
    }
    
}
