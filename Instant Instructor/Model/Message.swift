//
//  Message.swift
//  Find A Coach
//
//  Created by Christian Lizardi on 7/16/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
    @objc dynamic var sender: String? = nil
    @objc dynamic var body: String? = nil
    var parentConversation = LinkingObjects(fromType: Conversation.self, property: "messages")
}
