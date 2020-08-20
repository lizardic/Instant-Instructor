//
//  Conversation.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/19/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation

class Conversation: Codable, Identifiable {
    var id: String? = nil
    var senderUsername: String?
    var recipientUsername: String?
    
    init(senderUsername: String, recipientUsername: String) {
        self.senderUsername = senderUsername
        self.recipientUsername = recipientUsername
    }
}
