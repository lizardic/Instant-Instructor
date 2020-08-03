//
//  ViewController.swift
//  Find A Coach
//
//  Created by Christian Lizardi on 7/9/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var locationUpdater = LocationUpdater()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true 
        
        searchTextField.delegate = self
        locationUpdater.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.searchSegueProfile, sender: self)
    }
    
    @IBAction func filtersButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.searchSegueFilters, sender: self)
        
    }
    
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.searchSegueMessage, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.searchSegueMessage {
            _ = segue.destination as! MessageViewController
        }
        if segue.identifier == K.searchSegueFilters {
            _ = segue.destination as! SearchFilterViewController
        }
        if segue.identifier == K.searchSegueProfile {
            _ = segue.destination as! YourProfileViewController
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

