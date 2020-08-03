//
//  LaunchScreenViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/28/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = K.appName
        
    }
    
    @IBAction func signUpEmailButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.welcomeSegueRegister, sender: self)
    }
    
    @IBAction func signInEmailButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.welcomeSegueLogin, sender: self)
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
        if segue.identifier == K.welcomeSegueLogin {
            _ = segue.destination as! LoginViewController
        }
        if segue.identifier == K.welcomeSegueRegister {
            _ = segue.destination as! RegisterViewController
        }
      
        
    }
}
