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
    @NSManaged var detalhes: String
    @NSManaged var faculdade: Faculdade
    @NSManaged var nome: String
    
}
