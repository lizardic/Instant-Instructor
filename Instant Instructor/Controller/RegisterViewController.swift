//
//  RegisterChoiceViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/29/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var instructorButtonView: UIView!
    
    let realm = try! Realm()
    let newAccount = User()
    let newInstructor = Instructor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        instructorButtonView.layer.cornerRadius = instructorButtonView.frame.size.height / 5
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if fullNameTextField.text?.count == 0 {
            displayError(error: "Must fill in all fields")
        } else if confirmPasswordTextField.text == passwordTextField.text {
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.displayError(error: e.localizedDescription)
                    } else {
                        self.newAccount.name = self.fullNameTextField.text!
                        self.newAccount.username = self.usernameTextField.text!
                        self.newAccount.email = self.emailTextField.text!
                        self.newAccount.password = self.passwordTextField.text!
                        self.saveAccount(self.newAccount)
                        
                        self.performSegue(withIdentifier: K.registerSegueSearch, sender: self)
                    }
                }
                
            }
        } else {
            self.displayError(error: "Passwords don't match")
        }

    }
    func saveAccount(_ account: User) {
        do {
            try realm.write {
                realm.add(account)
            }
        } catch {
            print("Error saving account, \(error)")
        }
    }
    func displayError(error: String) {
        let alert = UIAlertController(title: "Failed Sign Up Attempt", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default) { (action) in
            //what will happen when you click dismiss
            print("Success")
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func instructorButtonPressed(_ sender: UIButton) {
        if fullNameTextField.text?.count == 0 {
             displayError(error: "Must fill in all fields")
         } else if confirmPasswordTextField.text == passwordTextField.text {
             if let email = emailTextField.text, let password = passwordTextField.text {
                 Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                     if let e = error {
                         self.displayError(error: e.localizedDescription)
                     } else {
                        self.newInstructor.name = self.fullNameTextField.text!
                        self.newInstructor.username = self.usernameTextField.text!
                        self.newInstructor.email = self.emailTextField.text!
                        self.newInstructor.password = self.passwordTextField.text!
                        
                         self.performSegue(withIdentifier: K.registerSegueInstructor, sender: self)
                     }
                 }
                 
             }
         } else {
             self.displayError(error: "Passwords don't match")
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.registerSegueInstructor {
            let destinationVC = segue.destination as! InstructorViewController
            destinationVC.newInstructor = newInstructor
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
    
}
