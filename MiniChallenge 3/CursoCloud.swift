//
//  CursoCloud.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/20/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit
import CloudKit

class CursoCloud : NSObject {
    
    var record : CKRecord!
    weak var database : CKDatabase!
    var nome : String!
    
    
    init(record : CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        
        self.nome = record.objectForKey("nome") as! String
    }
    
}