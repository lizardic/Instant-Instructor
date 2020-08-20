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
import FirebaseFirestore

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
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        //get correct user
        let email: String = (Auth.auth().currentUser?.email)!
        db.collection("User").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.currentUser = document.decode(as: User.self)
                    }
                }
        }
        prepareGeneral(currentUser!)
        if currentUser!.organizationCertified != nil {
            certifiedInstructorStack.isHidden = false
            experiencedInstructorStack.isHidden = true
            generalInstructorStack.isHidden = false
            prepareCertifiedStack(currentUser!)
            prepareGeneralInstructorStack(currentUser!)
        } else if currentUser!.yearsExperience != nil {
            certifiedInstructorStack.isHidden = true
            experiencedInstructorStack.isHidden = false
            generalInstructorStack.isHidden = false
            prepareExperiencedStack(currentUser!)
            prepareGeneralInstructorStack(currentUser!)
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
    func prepareGeneralInstructorStack(_ user: User) {
        sexLabel.text = user.sex
        activityLabel.text = user.activity
    }
    func prepareExperiencedStack(_ user: User) {
        workplaceLabel.text = "Current Workplace: " + user.workplace!
        workplaceTwoLabel.text = "Another Workplace: " + user.workplaceTwo!
        yearsExperienceLabel.text = "Years of Experience: \(user.yearsExperience!)"
        
    }
    
    func prepareCertifiedStack(_ user: User) {
        certifiedOrganizationLabel.text = "Certified By: " +  user.organizationCertified!
        expirationDateLabel.text = "Certification Expires: " + dateToString(user.certificationDate!)
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
