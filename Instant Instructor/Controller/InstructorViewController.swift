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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coachRequirementsLabel.text = K.instructorRequirements
    }
    
    @IBAction func certificationButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.instructorSegueCertification , sender: self)
    }
    
    @IBAction func experienceButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.instructorSegueWork, sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.instructorSegueCertification {
            _ = segue.destination as! CertificationViewController
        }
        if segue.identifier == K.instructorSegueWork {
            _ = segue.destination as! WorkViewController
        }
      
        
    }
    

}
