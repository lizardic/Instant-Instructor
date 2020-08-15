//
//  EditProfileViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/25/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import RealmSwift

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
    let realm = try! Realm()
    
    var currentUser: User?
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
    
    func prepareGeneral(_ user: User) {
        nameTextField.text = user.name
        usernameTextField.text = user.username
        emailTextField.text = user.email
        passwordTextField.text = user.password
        
    }
    func prepareGeneralInstructorStack(_ instructor: Instructor) {
        sexPicker.setValue(instructor.sex, forKey: "sex")
        activityPicker.setValue(instructor.activity, forKey: "activity")
    }
    func prepareExperiencedStack(_ instructor: Instructor) {
        workplace.text = instructor.workplace!
        workplaceTwo.text = instructor.workplaceTwo!
        yearsExperience.text =  instructor.yearsExperience!
        
    }
    
    func prepareCertifiedStack(_ instructor: Instructor) {
        certifiedOrganization.text = instructor.organizationCertified!
        datePicker.setValue(instructor.certificationDate, forKey: "date")
    }
    
    
    func updateInfo(_ textField: UITextField) {
        //get correct user
        let user = Instructor()
        if textField == nameTextField {
            do {
                try realm.write {
                    user.name = nameTextField.text
                }
            } catch {
                print("Error updating name, \(error)")
                }
            }
        else if textField == usernameTextField {
            do {
                try realm.write {
                    user.username = usernameTextField.text
                }
            } catch {
                print("Error updating username, \(error)")
            }
        }
        else if textField == emailTextField {
            do {
                try realm.write {
                    user.email = emailTextField.text
                }
            } catch {
                print("Error updating email, \(error)")
            }
            user.email = emailTextField.text
        } else if textField == passwordTextField {
            do {
                try realm.write {
                    user.password = passwordTextField.text
                }
            } catch {
                print("Error updating password, \(error)")
            }
        } else if textField == certifiedOrganization {
            do {
                try realm.write {
                    user.organizationCertified = certifiedOrganization.text
                }
            } catch {
                print("Error updating organization, \(error)")
            }
        } else if textField == workplace {
            do {
                try realm.write {
                    user.workplace = workplace.text
                }
            } catch {
                print("Error updating workplace, \(error)")
            }
            
        } else if textField == workplaceTwo {
            do {
                try realm.write {
                    user.workplaceTwo = workplaceTwo.text
                }
            } catch {
                print("Error updating other workplace, \(error)")
            }
        }
    }
    
    @IBAction func deleteAccountButtonPressed(_ sender: UIBarButtonItem) {
        //get correct user
        // distinguish between general account and instructor
        let user = User()
        do {
            try realm.write {
                realm.delete(user)
            }
        } catch {
            print("Error deleting account, \(error)")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

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
        updateInfo(textField)
        
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


