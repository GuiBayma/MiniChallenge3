//
//  Faculdade.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 15/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CoreData

@objc(Faculdade)
class Faculdade: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var tipoInstituicao: NSNumber
    @NSManaged var favorito: NSNumber
    @NSManaged var estado: String
    @NSManaged var cidade: String
    @NSManaged var siteWeb: String
    @NSManaged var aceitaEnem: NSNumber
    @NSManaged var vestibular: NSManagedObject
    @NSManaged var curso: Curso

}
