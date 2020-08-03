//
//  RegisterChoiceViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/29/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorDisplayLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorDisplayLabel.text = ""
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if confirmPasswordTextField.text == passwordTextField.text {
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.errorDisplayLabel.text = e.localizedDescription
                    } else {
                        self.performSegue(withIdentifier: K.registerSegueSearch, sender: self)
                    }
                }
                
            }
        } else {
            errorDisplayLabel.text = K.passwordsDontMatch
        }

    }
    
    @IBAction func instructorButtonPressed(_ sender: UIButton) {
        if confirmPasswordTextField.text == passwordTextField.text {
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.errorDisplayLabel.text = e.localizedDescription
                    } else {
                        self.performSegue(withIdentifier: K.registerSegueInstructor, sender: self)
                    }
                }
                
            }
        } else {
            errorDisplayLabel.text = K.passwordsDontMatch
        }
        
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
        if segue.identifier == K.registerSegueInstructor {
            _ = segue.destination as! InstructorViewController
        }
        if segue.identifier == K.registerSegueSearch {
            _ = segue.destination as! SearchViewController
        }
      
        
    }

}

//MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use the textField to do whatever you need
    }
    
}
