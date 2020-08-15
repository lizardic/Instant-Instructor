//
//  YourProfileViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/25/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class YourProfileViewController: UIViewController {
    var currentUser : User?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var certifiedOrganizationLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var workplaceTwoLabel: UILabel!
    @IBOutlet weak var yearsExperienceLabel: UILabel!
    @IBOutlet weak var generalInstructorStack: UIStackView!
    @IBOutlet weak var certifiedInstructorStack: UIStackView!
    @IBOutlet weak var experiencedInstructorStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get correct user
        let user = User()
        prepareGeneral(user)
        if let instructor = user as? Instructor {
            print(instructor)
            if instructor.organizationCertified != nil {
                certifiedInstructorStack.isHidden = false
                experiencedInstructorStack.isHidden = true
                generalInstructorStack.isHidden = false
                prepareCertifiedStack(instructor)
                prepareGeneralInstructorStack(instructor)
                
            } else {
                certifiedInstructorStack.isHidden = true
                experiencedInstructorStack.isHidden = false
                generalInstructorStack.isHidden = false
                prepareExperiencedStack(instructor)
                prepareGeneralInstructorStack(instructor)
            }
        } else {
            certifiedInstructorStack.isHidden = true
            experiencedInstructorStack.isHidden = true
            generalInstructorStack.isHidden = true
        }
        
    }
    
    func adjustToUser() {
        
    }

    
    func prepareGeneral(_ user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        usernameLabel.text = user.username
        
    }
    func prepareGeneralInstructorStack(_ instructor: Instructor) {
        sexLabel.text = instructor.sex
        activityLabel.text = instructor.activity
    }
    func prepareExperiencedStack(_ instructor: Instructor) {
        workplaceLabel.text = "Current Workplace: " + instructor.workplace!
        workplaceTwoLabel.text = "Another Workplace: " + instructor.workplaceTwo!
        yearsExperienceLabel.text = "Years of Experience: " + instructor.yearsExperience!
        
    }
    
    func prepareCertifiedStack(_ instructor: Instructor) {
        certifiedOrganizationLabel.text = "Certified By: " +  instructor.organizationCertified!
        expirationDateLabel.text = "Certification Expires: " + dateToString(instructor.certificationDate!)
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.profileSegue, sender: self)
    }
    

    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.profileSegue {
            _ = segue.destination as! EditProfileViewController
        }
       }

}
