//
//  VestibularCloud.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/20/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit
import CloudKit

class VestibularCloud : NSObject {
    
    var record : CKRecord!
    weak var database : CKDatabase!
    var nome : String!
    var detalhes : String!
    var dataInicioInsc : NSDate!
    var dataFimInsc : NSDate!
    var dataGabarito : NSDate!
    var dataChamada : NSDate!
    var dataProvas : NSDate!
    
    init(record : CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        
        self.nome = record.objectForKey("nome") as! String
        self.detalhes = record.objectForKey("detalhes") as! String
        self.dataInicioInsc = record.objectForKey("dataInicioInsc") as! NSDate
        self.dataFimInsc = record.objectForKey("dataFimInsc") as! NSDate
        self.dataGabarito = record.objectForKey("dataGabarito") as! NSDate
        self.dataChamada = record.objectForKey("dataChamada") as! NSDate
        self.dataProvas = record.objectForKey("dataProvas") as! NSDate
    }
    
}