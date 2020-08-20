//
//  InstructorProfileViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/3/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var certifiedStack: UIStackView!
    @IBOutlet weak var experiencedStack: UIStackView!
    var conversation: Conversation?
    var instructor : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustToInstructor()
        
    }

    @IBAction func newMessageButonPressed(_ sender: UIBarButtonItem) {
        let newConversation = Conversation(senderUsername: "sender", recipientUsername: "recipient")
        conversation = newConversation
        FirestoreService.shared.create(for: newConversation, to: .Conversation)
        self.performSegue(withIdentifier: K.instructorSegueMessages, sender: self)
    }

 
    
    func adjustToInstructor() {
        navigationBar.title = instructor!.username
        nameLabel.text = instructor!.name
        emailLabel.text = instructor!.email
        activityLabel.text = instructor!.activity
        sexLabel.text = instructor!.sex
        if instructor?.organizationCertified != nil {
            certifiedStack.isHidden = false
            experiencedStack.isHidden = true
            prepareCertifiedStack()
            
        } else {
            certifiedStack.isHidden = true
            experiencedStack.isHidden = false
            prepareExperiencedStack()
        }

        }
    func prepareExperiencedStack() {

        if experiencedStack.isHidden == false && certifiedStack.isHidden == true {
            let workplace = instructor?.workplace
            workplaceLabel.text = "Current Workplace:  " + workplace!
            
            
            let workplaceTwo = instructor?.workplaceTwo
            workplaceTwoLabel.text = "Past Workplace:  " + workplaceTwo!
            

            let years = instructor?.yearsExperience
            yearsExperienceLabel.text = "Experience (years):  \(years!)" 
            
        }

    }
    
    func prepareCertifiedStack() {
        if experiencedStack.isHidden == true && certifiedStack.isHidden == false {
            let organization = instructor?.organizationCertified
            certifiedOrganizationLabel.text = "Certified By:  " + organization!
    
            let date = instructor?.certificationDate
            dateLabel.text = "Certification Expires:  \(date!)"
    
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.instructorSegueMessages {
            let destinationVC = segue.destination as! MessageViewController
            destinationVC.parentConversation = self.conversation
        }
    }
}
