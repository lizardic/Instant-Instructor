//
//  GeneralAccount.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/6/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import RealmSwift

class GeneralAccount: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var username: String?
}
