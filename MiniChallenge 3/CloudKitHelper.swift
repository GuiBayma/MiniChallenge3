//
//  CloudKitHelper.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/20/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import Foundation
import CloudKit


protocol CloudKitHelperDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}

@objc class CloudKitHelper {
    
    class func sharedInstance() -> CloudKitHelper {
        return CloudKitHelperSingleton
    }
    
    var delegate : CloudKitHelperDelegate?
    
    var faculdades = [FaculdadeCloud]()
    var vestibulares = [VestibularCloud]()
    var cursos = [CursoCloud]()
    
    let container : CKContainer
    let publicDB : CKDatabase
    let privateDB : CKDatabase
    
    init() {
        container = CKContainer.defaultContainer() //1
        publicDB = container.publicCloudDatabase //2
        privateDB = container.privateCloudDatabase //3
        
    }
    
    func refreshFaculdade(notification: NSNotification) {
        let predicate = NSPredicate(value: true)
        //let sort = NSSortDescriptor(key: "Name", ascending: false)
        let query = CKQuery(recordType: "Faculdade", predicate: predicate)
        //query.sortDescriptors = [sort]
        publicDB.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else {
                self.faculdades.removeAll(keepCapacity: true)
                for record in results {
                    let faculdade = FaculdadeCloud(record: record as! CKRecord, database:self.publicDB)
                    self.faculdades.append(faculdade)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    println()
                }
            }
        }
    }
    
    func refreshVestibular(notification: NSNotification) {
        let predicate = NSPredicate(value: true)
        //let sort = NSSortDescriptor(key: "dataProvas", ascending: true)
        let query = CKQuery(recordType: "Vestibular", predicate: predicate)
        //query.sortDescriptors = [sort]
        publicDB.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else {
                self.vestibulares.removeAll(keepCapacity: true)
                for record in results {
                    let vestibular = VestibularCloud(record: record as! CKRecord, database:self.publicDB)
                    self.vestibulares.append(vestibular)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    println()
                }
            }
        }
    }
    
    func refreshCurso(notification: NSNotification) {
        let predicate = NSPredicate(value: true)
        //let sort = NSSortDescriptor(key: "Name", ascending: false)
        let query = CKQuery(recordType: "Curso", predicate: predicate)
        //query.sortDescriptors = [sort]
        publicDB.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else {
                self.cursos.removeAll(keepCapacity: true)
                for record in results {
                    let curso = CursoCloud(record: record as! CKRecord, database:self.publicDB)
                    self.cursos.append(curso)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    println()
                }
            }
        }
    }
}

let CloudKitHelperSingleton = CloudKitHelper()