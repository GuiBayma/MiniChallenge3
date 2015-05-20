//
//  CloudKit.swift
//  MiniChallenge 3
//
//  Created by Rafael Souza Belchior da Silva on 19/05/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CloudKit

protocol CloudKitDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}


class CloudKit {
    var container : CKContainer
    var publicDB : CKDatabase
    let privateDB : CKDatabase
    var delegate : CloudKitDelegate?
    var vestibulares = [Vestibular]()
    
    class func sharedInstance() -> CloudKit {
        return cloudKit
    }
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
//    func saveRecord(todo : NSString) {
//        let todoRecord = CKRecord(recordType: "Todos")
//        todoRecord.setValue(todo, forKey: "todotext")
//        publicDB.saveRecord(todoRecord, completionHandler: { (record, error) -> Void in
//            NSLog("Before saving in cloud kit : \(self.todos.count)")
//            NSLog("Saved in cloudkit")
//            self.fetchTodos(record)
//        })
//        
//    }
    
    func fetchTodos(insertedRecord: CKRecord?) {
        let predicate = NSPredicate(value: true)
        var i = 0
        let query = CKQuery(recordType: "Vestibular",
            predicate:  predicate)
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    return
                }
            } else {
                self.vestibulares.removeAll(keepCapacity: true)
                for record in results{
                    let vestibular = Vestibular(record: record as! CKRecord, database: self.publicDB)
                    self.vestibulares.append(vestibular)
                    
                }
                if let tmp = insertedRecord {
                    let vestibular = Vestibular(record: insertedRecord! as CKRecord, database: self.publicDB)
                    /* Work around at the latest entry at index 0 */
                    self.vestibulares.insert(vestibular, atIndex: 0)
                }
                NSLog("fetch after save : \(self.vestibulares.count)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    return
                }
            }
        }
    }
}
let cloudKit = CloudKit()