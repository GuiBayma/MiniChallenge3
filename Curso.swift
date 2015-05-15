//
//  Curso.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 15/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CoreData

@objc(Curso)
class Curso: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var faculdade: NSManagedObject

}
