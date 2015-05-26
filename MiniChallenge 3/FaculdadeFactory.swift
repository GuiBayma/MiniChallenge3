//
//  FaculdadeFactory.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 25/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit
import CoreData

class FaculdadeFactory: NSObject {
    
    static func createFaculdade(nomeFaculdade: String, username: String) {
        let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Faculdade", inManagedObjectContext: contexto!)
        let faculdade = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Faculdade
        
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    
}