//
//  FirestoreService.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/19/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirestoreService {
    
    private init() {}
    static let shared = FirestoreService()

    
    private func reference(to collectionName: FirestoreCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionName.rawValue)
    }
    
    func create<T: Encodable>(for encodableObject: T, to collectionName: FirestoreCollectionReference) {
        do {
            let json = try encodableObject.toJson(excluding: ["id"])
            reference(to: collectionName).addDocument(data: json)
        } catch {
            print("Error creating data, \(error)")
        }
        
    }
    
    func read<T: Decodable>(from collectionName: FirestoreCollectionReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void ) {
        //get correct reference
        let currentReference = reference(to: collectionName)
        currentReference.addSnapshotListener {(snapshot, error) in
            // always observing so this is called whenever anything is added
            if let e = error {
                print(e)
            }
            guard let snapshot = snapshot else {return}
            var objects = [T]()
            for document in snapshot.documents {
            let object = document.decode(as: objectType.self)
            if object != nil {
                objects.append(object!)
            }
            completion(objects)
            }
        }
    }

    func update<T: Encodable & Identifiable>(for encodableObject: T, to collectionName: FirestoreCollectionReference) {
        //get correct reference
        //store path to data you want to update and data you want to update with to pass as inputs
        do {
            let json = try encodableObject.toJson(excluding: ["id"])
            guard let id = encodableObject.id else {throw MyError.encodingError}
            reference(to: collectionName).document(id).setData(json)
        } catch {
            print(error)
        }
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, in collectionName: FirestoreCollectionReference) throws {
        do {
            guard let id = identifiableObject.id else {throw MyError.encodingError}
            reference(to: collectionName).document(id).delete()
        }
    }
}

