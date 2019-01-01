//
//  Message.swift
//  Bulletin
//
//  Created by Steve Lederer on 12/31/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    static let RecordType = "Message"
    private let TextKey = "text"
    private let TimestampKey = "timestamp"
    
    let text: String
    let timestamp: Date
    
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    init?(cloudKitRecord: CKRecord) {
        //1) Get all of the necessary properties out of the dictionary (CKRecord) guard else {return nil}
        
        guard let text = cloudKitRecord[TextKey] as? String,
            let timestamp = cloudKitRecord[TimestampKey] as? Date else { return nil }
        
        //2) initialize the properties with the values you got in step 1
        
        self.text = text
        self.timestamp = timestamp
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Message.RecordType)
        //below are two different ways to set values for record
        record.setValue(text, forKey: TextKey)
        record[TimestampKey] = timestamp
        return record
    }
}
