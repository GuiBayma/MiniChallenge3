//
//  CursoFactory.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 26/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit
import CoreData

class CursoFactory: NSObject {
    
    static func createCurso(nomeFaculdade: String, username: String) {
        let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Vestibular", inManagedObjectContext: contexto!)
        let faculdade = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Vestibular
        
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    
}