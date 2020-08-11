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
    var participants = List<GeneralAccount>()
    var messages = List<Message>()
}
