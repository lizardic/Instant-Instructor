//
//  EditProfileViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/25/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var generalInstructorStack: UIStackView!
    @IBOutlet weak var certifiedInstructorStack: UIStackView!
    @IBOutlet weak var experiencedInstructorStack: UIStackView!
    //SET UP OUTLETS WTIH TEXTFIELDS
    var currentUser: GeneralAccount? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //SET UP TEXT FIELDS WITH CURRENT USERS INFORMATION
        //GET RID OF CERTAIN STACK VIEWS BASED ON THE PERSONS INFO
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //UPDATE USER INFORMATION
        
    }
}
