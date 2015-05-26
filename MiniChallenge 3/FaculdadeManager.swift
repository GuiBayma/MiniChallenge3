//
//  FaculdadeManager.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 25/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import CoreData
import UIKit

public class FaculdadeManager {
    static let sharedInstance:FaculdadeManager = FaculdadeManager()
    static let entityName:String = "Faculdade"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newFaculdade() -> Faculdade {
        return NSEntityDescription.insertNewObjectForEntityForName(FaculdadeManager.entityName, inManagedObjectContext: managedContext) as! Faculdade
    }
    
    func saveFaculdade() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findFaculdade() -> [Faculdade] {
        let fetchRequest = NSFetchRequest(entityName: FaculdadeManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Faculdade] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return [Faculdade]()
    }
    
}