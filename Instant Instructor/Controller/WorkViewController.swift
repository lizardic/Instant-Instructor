//
//  WorkViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/30/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import RealmSwift

class WorkViewController: UIViewController {

    @IBOutlet weak var workPlaceTextField: UITextField!
    
    @IBOutlet weak var workPlaceTwoTextField: UITextField!
    
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var sexPicker: UIPickerView!
    var currentActivity: String?
    var currentSex: String?
    var newInstructor: Instructor? 
    
    let activityArray: Array = K.activityArray
    let sexArray: Array = K.sexArray
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workPlaceTextField.delegate = self
        workPlaceTwoTextField.delegate = self
        yearsTextField.delegate = self
        activityPicker.delegate = self
        activityPicker.dataSource = self
        sexPicker.delegate = self
        sexPicker.dataSource = self
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
       
        if let workplace = workPlaceTextField.text {
            newInstructor?.workplace = workplace
        } else {
            displayError(error: "Fill out workplace")
        }
        newInstructor?.workplaceTwo = workPlaceTwoTextField.text ?? ""
        if let yearsExperience = yearsTextField.text {
            newInstructor?.yearsExperience = yearsExperience
        } else {
            displayError(error: "Fill out # of years experience")
        }
        if currentActivity != "" {
            newInstructor?.activity = currentActivity
        } else {
            displayError(error: "Pick activity")
        }
        if currentSex != "" {
            newInstructor?.sex = currentSex
            self.performSegue(withIdentifier: K.workSegue, sender: self)
            saveInstructor(newInstructor!)
        } else {
            displayError(error: "Pick sex")
        }
    
        
        
        
    }
    
    func saveInstructor(_ instructor: Instructor) {
        do {
            try realm.write {
                realm.add(instructor)
            }
        } catch {
            print("Error saving instructor, \(error)")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.workSegue {
            _ = segue.destination as! SearchViewController
        }

    }
}
//MARK: - UITextFieldDelegate

extension WorkViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use the textfield to do whatever you need
    }
    
}

//MARK: - UIPickerViewDataSource

extension WorkViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sexPicker {
            return sexArray.count
        }
        else if pickerView == activityPicker {
            return activityArray.count
        }
        return 0
        
    }
}

//MARK: - UIPickerViewDelegate

extension WorkViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sexPicker {
            return sexArray[row]
        }
        else if pickerView == activityPicker {
            return activityArray[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: component, animated: true)
        if pickerView == sexPicker {
            currentSex = sexArray[row]
        }
        if pickerView == activityPicker {
            currentActivity = activityArray[row]
        }
    }
}

