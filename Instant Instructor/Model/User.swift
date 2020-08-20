//
//  GeneralAccount.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/6/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation

class User: Codable, Identifiable {
    var id: String? = nil
    var name: String
    var email: String
    var password: String
    var username: String
    var activity: String?
    var sex: String?
    var workplace: String?
    var workplaceTwo: String?
    var yearsExperience: Int?
    var organizationCertified: String?
    var certificationDate: Date?
    
    init(name: String, email: String, password: String, username: String, activity: String? = nil, sex: String? = nil, workplace: String? = nil, workplaceTwo: String? = nil, yearsExperience: Int? = nil, organizationCertified: String? = nil, certificationDate: Date? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.username = username
        self.activity = activity
        self.sex = sex
        self.workplace = workplace
        self.workplaceTwo = workplaceTwo
        self.yearsExperience = yearsExperience
        self.organizationCertified = organizationCertified
        self.certificationDate = certificationDate
    }
}

protocol Identifiable {
    var id: String? { get set}
}
