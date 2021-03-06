//
//  RegisterInstructorViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/30/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

class InstructorViewController: UIViewController {

    @IBOutlet weak var coachRequirementsLabel: UILabel!
    var newInstructor: User?
    
    @IBOutlet weak var certificationButtonView: UIView!
    @IBOutlet weak var experiencedButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coachRequirementsLabel.text = K.instructorRequirements
        certificationButtonView.layer.cornerRadius = certificationButtonView.frame.size.height / 5
        experiencedButtonView.layer.cornerRadius = experiencedButtonView.frame.size.height / 5
    }
    
    @IBAction func certificationButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.instructorSegueCertification , sender: self)
    }
    
    @IBAction func experienceButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.instructorSegueWork, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.instructorSegueCertification {
            let destinationVC = segue.destination as! CertificationViewController
            destinationVC.newInstructor = newInstructor
        }
        if segue.identifier == K.instructorSegueWork {
            let destinationVC = segue.destination as! WorkViewController
            destinationVC.newInstructor = newInstructor
        }

      
        
    }
    

}
