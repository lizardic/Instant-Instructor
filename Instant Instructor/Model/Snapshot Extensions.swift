//
//  Snapshot Extensions.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/19/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) -> T? {
        var documentJson = data()
        if includingId {
            documentJson!["id"] = documentID
        }
        do {
            let documentData = try JSONSerialization.data(withJSONObject: documentJson!, options: [])
            let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
            
            return decodedObject
        } catch {
            print("Error decoding, \(error)")
        }
        return nil
    }

}
