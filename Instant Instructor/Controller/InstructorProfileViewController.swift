//
//  InstructorProfileViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/3/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import RealmSwift

class InstructorProfileViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var certifiedOrganizationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var workplaceTwoLabel: UILabel!
    @IBOutlet weak var yearsExperienceLabel: UILabel!
    
    let realm = try! Realm()
    var instructor : Instructor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustToInstructor()
    }

    @IBAction func newMessageButonPressed(_ sender: UIBarButtonItem) {
        let newConversation = Conversation()
        newConversation.participants.append(self.instructor!)
        saveConversation(newConversation)
        self.performSegue(withIdentifier: K.instructorSegueMessages, sender: self)
    }

    func saveConversation(_ conversation: Conversation) {
        do {
            try realm.write {
                realm.add(conversation)
            }
        } catch {
            print("Error saving conversation, \(error)")
        }
    }
    
    func adjustToInstructor() {
        navigationBar.title = instructor!.username
        nameLabel.text = instructor!.name
        emailLabel.text = instructor!.email
        activityLabel.text = instructor!.activity
        if let organization : String = instructor!.organizationCertified {
            certifiedOrganizationLabel.isHidden = false
            certifiedOrganizationLabel.text = "Certified By: \(organization)"
        } else {
            certifiedOrganizationLabel.isHidden = true
        }
        if let date : Date = instructor!.certificationDate {
            dateLabel.isHidden = false
            dateLabel.text = "Expiration Date: \(date)"
        } else {
            dateLabel.isHidden = true
        }
        if let workplace : String = instructor!.workplace {
            workplaceLabel.isHidden = false
            workplaceLabel.text = "Current Workplace: \(workplace)"
        } else {
            workplaceLabel.isHidden = true
        }
        if let workplaceTwo : String = instructor!.workplaceTwo {
            workplaceTwoLabel.isHidden = false
            workplaceTwoLabel.text = "Past Workplace: \(workplaceTwo)"
        } else {
            workplaceTwoLabel.isHidden = true
        }
        if let years : String = instructor!.yearsExperience {
            yearsExperienceLabel.isHidden = false
            yearsExperienceLabel.text = "Experience (years): \(years)"
        } else {
            yearsExperienceLabel.isHidden = true
        }
        
    }
}
