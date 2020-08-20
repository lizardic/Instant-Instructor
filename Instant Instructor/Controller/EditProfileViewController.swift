//
//  EditProfileViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/25/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var certifiedOrganization: UITextField!
    @IBOutlet weak var workplace: UITextField!
    @IBOutlet weak var workplaceTwo: UITextField!
    @IBOutlet weak var yearsExperience: UITextField!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var sexPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var generalInstructorStack: UIStackView!
    @IBOutlet weak var certifiedInstructorStack: UIStackView!
    @IBOutlet weak var experiencedInstructorStack: UIStackView!
    
    var currentSex: String?
    var currentActivity: String?
    
    var currentUser: User?
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("User").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "")
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
    
    func prepareGeneral(_ user: User) {
        nameTextField.text = user.name
        usernameTextField.text = user.username
        emailTextField.text = user.email
        passwordTextField.text = user.password
        
    }
    func prepareGeneralInstructorStack(_ user: User) {
        sexPicker.setValue(user.sex, forKey: "sex")
        activityPicker.setValue(user.activity, forKey: "activity")
    }
    func prepareExperiencedStack(_ user: User) {
        workplace.text = user.workplace!
        workplaceTwo.text = user.workplaceTwo!
        yearsExperience.text =  String(user.yearsExperience!)
        
    }
    
    func prepareCertifiedStack(_ user: User) {
        certifiedOrganization.text = user.organizationCertified!
        datePicker.setValue(user.certificationDate, forKey: "date")
    }
    
    @IBAction func deleteAccountButtonPressed(_ sender: UIBarButtonItem) {
        //should probably show an are you sure? screen
        do {
            try FirestoreService.shared.delete(currentUser!, in: .User)
            self.performSegue(withIdentifier: K.editSegue, sender: self)
        } catch {
            print("Error deleting account, \(error)")
        }
    }
    
    func newUserInfo(tf: UITextField) -> User {
        let updatedUser = currentUser!
        if tf == nameTextField {
            updatedUser.name = nameTextField.text!
        } else if tf == emailTextField {
            updatedUser.email = emailTextField.text!
        } else if tf == usernameTextField {
            updatedUser.username = usernameTextField.text!
        } else if tf == passwordTextField {
            updatedUser.password = passwordTextField.text!
        } else if tf == workplace {
            updatedUser.workplace = workplace.text!
        } else if tf == workplaceTwo {
            updatedUser.workplaceTwo = workplaceTwo.text!
        } else if tf == yearsExperience {
            updatedUser.yearsExperience = Int(yearsExperience.text!)
        }
        return updatedUser
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.editSegue {
            _ = segue.destination as! WelcomeViewController
        }
    }

}

//MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let user = newUserInfo(tf: textField)
        FirestoreService.shared.update(for: user, to: .User)
        
    }
}


//MARK: - UIPickerViewDataSource

extension EditProfileViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sexPicker {
            return 3
        }
        else if pickerView == activityPicker {
            return K.activityArray.count
        }
        return 0
        
    }
}

//MARK: - UIPickerViewDelegate

extension EditProfileViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sexPicker{
            return K.sexArray[row]
        }
        else if pickerView == activityPicker {
            return K.activityArray[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: component, animated: true)
        if pickerView == sexPicker {
            currentSex = K.sexArray[row]
        }
        if pickerView == activityPicker {
            currentActivity = K.activityArray[row]
        }
    }
}


