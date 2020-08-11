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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
