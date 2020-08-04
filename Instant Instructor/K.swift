//
//  Constants.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/1/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation

struct K {
    static let searchSegueMessageChoice = "searchToMessageChoice"
    static let searchSegueFilters = "searchToFilters"
    static let searchSegueProfile = "searchToProfile"
    static let searchSegueInstructor = "searchToInstructor"
    static let profileSegue = "profileToEdit"
    static let welcomeSegueLogin = "welcomeToLogin"
    static let welcomeSegueRegister = "welcomeToRegister"
    static let registerSegueInstructor = "registerToInstructor"
    static let registerSegueSearch = "registerToSearch"
    static let loginSegue = "loginToSearch"
    static let instructorSegueCertification = "instructorToCertification"
    static let instructorSegueWork = "instructorToWork"
    static let workSegue = "workToSearch"
    static let certificationSegue = "certificationToSearch"
    static let messageChoiceSegueMessages = "messageChoiceToMessages"
    static let messageChoiceSegueNewMessage = "messageChoiceToNewMessage"
    static let newMessageSegue = "newMessageToMessages"
    static let instructorSegueMessages = "instructorToMessages"
    
    static let passwordsDontMatch = "Passwords do not match"
    static let instructorRequirements = "To become an Instructor on Instant Instructor, you must either have received certification to teach the activity or have taught the activity professionally at an organization. If neither of these apply to you, please do not create an Instructor account. "
    static let activityArray = ["Badminton", "Ballet", "Baseball", "Basketball", "Boxing", "Cello", "Clarinet", "Cricket", "Drawing", "Field Hockey", "Flute", "Football", "Golf", "Guitar", "Harp", "Hip Hop Dance", "Hockey", "Irish Dance", "Jazz Dance", "Latin Dance", "Modern/Lyrical Dance", "Oboe", "Painting", "Percussion", "Photography", "Piano", "Rugby", "Saxophone", "Sculpture", "Skiing", "Snowboarding", "Soccer", "Swimming", "Tap", "Tennis", "Textiles", "Track & Field", "Trombone", "Trumpet", "Tuba", "Violin", "Vocals", "Volleyball", "Woodwork",  "Wrestling"]
    static let sexArray = ["Male", "Female", "Any"]
    static let appName = "Instant Instructor"
    
    static let messageCell = "Message Cell"
    static let messageCellNib = "MessageCell"
    static let messageChoiceCell = "Message Choice Cell"
    static let messageChoiceCellNib = "MessageChoiceCell"
    static let instructorCell = "Instructor Cell"
    static let instructorCellNib = "InstructorCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
