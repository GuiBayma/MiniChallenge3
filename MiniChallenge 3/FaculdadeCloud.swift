//
//  FaculdadeCloud.swift
//  MiniChallenge 3
//
//  Created by Guilherme Bayma on 5/20/15.
//  Copyright (c) 2015 Guilherme Bayma. All rights reserved.
//

import UIKit
import CloudKit

class FaculdadeCloud : NSObject {
    
    var record : CKRecord!
    var name : String!
    var descricao : String!
    weak var database : CKDatabase!
    
    var assetCount = 0
    
    init(record : CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        
        self.name = record.objectForKey("Name") as! String
        self.descricao = record.objectForKey("Descricao") as! String
    }
    
    func fetchPhotos(completion:(assets: [CKRecord]!)->()) {
        let predicate = NSPredicate(format: "Faculdades == %@", record)
        let query = CKQuery(recordType: "Photo", predicate: predicate);
        //Intermediate Extension Point - with cursors
        database.performQuery(query, inZoneWithID: nil) { results, error in
            if error == nil {
                self.assetCount = results.count
            }
            completion(assets: results as! [CKRecord])
        }
    }
    
    func loadCoverPhoto(completion:(photo: UIImage!) -> ()) {
        // 1
        dispatch_async(
            dispatch_get_global_queue(
                DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)){
                    var image: UIImage!
                    // 2
                    if let asset = self.record.objectForKey("Photo") as? CKAsset {
                        // 3
                        if let url = asset.fileURL {
                            let imageData = NSData(contentsOfFile: url.path!)!
                            // 4
                            image = UIImage(data: imageData)
                        }
                    }
                    // 5
                    completion(photo: image)
        }
    }
    
    
}