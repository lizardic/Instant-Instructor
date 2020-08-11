//
//  Instructor.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/7/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import RealmSwift

class Instructor: GeneralAccount {
    @objc dynamic var activity: String = ""
    @objc dynamic var sex: String = ""
    @objc dynamic var workplace: String?
    @objc dynamic var workplaceTwo: String?
    @objc dynamic var yearsExperience: String?
    @objc dynamic var organizationCertified: String?
    @objc dynamic var certificationDate: Date?
}
