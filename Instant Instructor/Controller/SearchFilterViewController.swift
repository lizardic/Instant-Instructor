//
//  SearchFilterViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/25/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

class SearchFilterViewController: UIViewController {

    @IBOutlet weak var proximityValue: UILabel!
    @IBOutlet weak var starsValue: UILabel!
    @IBOutlet weak var ageValue: UILabel!
    
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var sexPicker: UIPickerView!
    var currentActivity: String? = nil
    var currentSex: String? = nil
    
    let activityArray: Array = K.activityArray
    
    let sexArray: Array = K.sexArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityPicker.delegate = self
        activityPicker.dataSource = self
        sexPicker.delegate = self
        sexPicker.dataSource = self
        
    }
    

    @IBAction func proximityValueChange(_ sender: UISlider) {
        let proximity = String(format: "%.0f", sender.value)
        proximityValue.text = "\(proximity) miles"
        sender.setValue(sender.value, animated: true)
        
    }
    
    @IBAction func starsValueChange(_ sender: UISlider) {
        let stars = String(format: "%.0f", sender.value)
        starsValue.text = "\(stars) stars"
    }
    
    @IBAction func ageValueChange(_ sender: UISlider) {
        let age = String(format: "%.0f", sender.value)
        ageValue.text = "\(age) years old"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
      
        
}


//MARK: - UIPickerViewDataSource

extension SearchFilterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sexPicker {
            return 3
        }
        else if pickerView == activityPicker {
            return activityArray.count
        }
        return 0
        
    }
}

//MARK: - UIPickerViewDelegate

extension SearchFilterViewController: UIPickerViewDelegate {
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
