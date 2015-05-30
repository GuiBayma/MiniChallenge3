//
//  Vestibular.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 30/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CoreData

@objc(Vestibular)
class Vestibular: NSManagedObject {

    @NSManaged var dataChamada: AnyObject?
    @NSManaged var dataFimInsc: NSDate
    @NSManaged var dataGabarito: NSDate?
    @NSManaged var dataInicioInsc: NSDate
    @NSManaged var dataProvas: AnyObject
    @NSManaged var detalhes: String?
    @NSManaged var nome: String
    @NSManaged var favorito: NSNumber
    @NSManaged var faculdade: Faculdade

}
