//
//  MessageController.swift
//  Bulletin
//
//  Created by Steve Lederer on 12/31/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    static let shared = MessageController()
    
    func saveMessageToCloudKit(text: String, completion: @escaping (Message?) -> ()) {
        let message = Message(text: text)
        let record = message.cloudKitRecord
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
            if let error = error {
                print("❌ There was an error in \(#function) ; \(error.localizedDescription) ❌")
                completion(nil)
                return
            }
            guard let record = record else { completion(nil) ; return }
            let message = Message(cloudKitRecord: record)
            completion(message)
        }
    }
    
    func fetchAllMessageFromCloudKit(completion: @escaping ([Message]?) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Message.RecordType, predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("❌ There was an error in \(#function) ; \(error.localizedDescription) ❌")
                completion(nil)
                return
            }
            guard let records = records else { completion(nil) ; return }
            let messages = records.compactMap({ (record) -> Message? in
                return Message(cloudKitRecord: record)
            })
            completion(messages)
            
        }
    }
}
