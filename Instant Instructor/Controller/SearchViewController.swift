//
//  SearchViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/4/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UITableViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var locationUpdater = LocationUpdater()
    let instructorArray = ["Bob The Builder", "Nathaniel Bacon", "Kendrick Lamar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        
        searchTextField.delegate = self
        locationUpdater.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        tableView.register(UINib(nibName: K.instructorCellNib, bundle: nil), forCellReuseIdentifier: K.instructorCell)
        
    }
    
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: K.searchSegueProfile, sender: self)
    }
    
    @IBAction func filtersButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.searchSegueFilters, sender: self)
        
    }
    
    
    @IBAction func messageButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: K.searchSegueMessageChoice, sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return instructorArray.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: K.instructorCell, for: indexPath) as! InstructorChoiceCell
           
           cell.profileNameLabel.text = instructorArray[indexPath.row]
           
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let messageSender = instructorArray[indexPath.row]
           print(messageSender)
           
           tableView.deselectRow(at: indexPath, animated: true)
           self.performSegue(withIdentifier: K.searchSegueInstructor, sender: self)
    
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.searchSegueMessageChoice {
            _ = segue.destination as! MessageChoiceViewController
        }
        if segue.identifier == K.searchSegueFilters {
            _ = segue.destination as! SearchFilterViewController
        }
        if segue.identifier == K.searchSegueProfile {
            _ = segue.destination as! YourProfileViewController
        }
        if segue.identifier == K.searchSegueInstructor {
            _ = segue.destination as! InstructorProfileViewController
        }

    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        locationManager.requestLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use the searchTextField.text to do whatever you need
        searchTextField.text = ""
    }
    
}

//MARK: - CLLocationManagerDele

extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //called when location is updated
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            locationUpdater.applyLocation(location) //calls didUpdateLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //called when location fails to update
        print(error)
    }
    
}

//MARK: - LocationUpdaterDelegate

extension SearchViewController: LocationUpdaterDelegate {
    func didUpdateLocation(_ locationUpdater: LocationUpdater, _ location: CLLocation) {
        //use location
        print(location)
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

