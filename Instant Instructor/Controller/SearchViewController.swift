//
//  SearchViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/4/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var locationUpdater = LocationUpdater()
    var users : [User]?
    var user: User?
    var activityFilter: String?
    var sexFilter: String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        
        searchBar.delegate = self
        locationUpdater.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        tableView.register(UINib(nibName: K.instructorCellNib, bundle: nil), forCellReuseIdentifier: K.instructorCell)
        loadUsers()
       }
        
        
        
        
    func loadUsers() {
        FirestoreService.shared.read(from: .User, returning: User.self) { (users) in
            self.users = users
            self.tableView.reloadData()
        }
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
  
    func query(searchText: String, sex: String, activity: String) {
        //use filters to adjust instructorArray
        
        loadUsers()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.searchSegueMessageChoice {
            _ = segue.destination as! MessageChoiceViewController
        }
        if segue.identifier == K.searchSegueFilters {
            let destinationVC = segue.destination as! SearchFilterViewController
            destinationVC.previousVC = self
        }
        if segue.identifier == K.searchSegueProfile {
            _ = segue.destination as! YourProfileViewController
        }
        if segue.identifier == K.searchSegueInstructor {
            let destinationVC = segue.destination as! InstructorProfileViewController
            destinationVC.instructor = self.user
        }

    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        query(searchText: searchBar.text ?? "", sex: sexFilter ?? "", activity: activityFilter ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query(searchText: searchBar.text ?? "", sex: sexFilter ?? "", activity: activityFilter ?? "")
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

extension SearchViewController: UITableViewDataSource {
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users!.count
    }
         
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.instructorCell, for: indexPath) as! InstructorChoiceCell
        cell.profileNameLabel.text = users![indexPath.row].username
          
        return cell
      }
         
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.user = users![indexPath.row]
              
                 
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: K.searchSegueInstructor, sender: self)
      }
    
}
