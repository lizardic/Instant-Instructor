//
//  Conversation.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/10/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import RealmSwift

class Conversation: Object {
    @objc dynamic var sender: String?
    var participants = List<User>()
    var messages = List<Message>()
}
