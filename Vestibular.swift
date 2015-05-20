//
//  Vestibular.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 15/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(Vestibular)
class Vestibular: NSManagedObject {

    @NSManaged var dataInicioInsc: NSDate
    @NSManaged var dataFimInsc: NSDate
    @NSManaged var dataGabarito: NSDate
    @NSManaged var dataChamada: NSDate
    @NSManaged var dataProvas: NSDate
//    @NSManaged var detalhes: String
    @NSManaged var faculdade: Faculdade
//    @NSManaged var nome: String
    
    var nome : String!
    var detalhes : String!
    var record : CKRecord!
    weak var database : CKDatabase!
    init(record : CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        self.nome = record.objectForKey("nome") as! String
        self.detalhes = record.objectForKey("detalhes") as? String
    }
}
