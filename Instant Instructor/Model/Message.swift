//
//  Message.swift
//  Find A Coach
//
//  Created by Christian Lizardi on 7/16/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation

class Message: Codable {
    var senderUsername: String?
    var recipientUsername: String?
    var body: String?
    var date: Date?
    
    init(senderUsername: String, recipientUsername: String, body: String, date: Date) {
        self.senderUsername = senderUsername
        self.recipientUsername = recipientUsername
        self.body = body
        self.date = date
    }
}

