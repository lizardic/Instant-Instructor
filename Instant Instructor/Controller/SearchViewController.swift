//
//  SearchViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/4/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class SearchViewController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let locationManager = CLLocationManager()
    var locationUpdater = LocationUpdater()
    var instructorArray : Results<Instructor>? 
    var instructor : Instructor = Instructor()
    let realm = try! Realm()
    let defaultInstructor = Instructor()
    var activityFilter: String?
    var sexFilter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultInstructor.username = "No instructors match search"
        navigationItem.hidesBackButton = true
        
        searchBar.delegate = self
        locationUpdater.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        
        loadInstructors("")
        tableView.register(UINib(nibName: K.instructorCellNib, bundle: nil), forCellReuseIdentifier: K.instructorCell)
        
        
    }
    
    func loadInstructors(_ searchText: String) {
        instructorArray = realm.objects(Instructor.self)
        var predicateArray : [NSPredicate] = []
        let usernamePredicate = NSPredicate(format: "username CONTAINS[cd] %@", searchText)
        predicateArray.append(usernamePredicate)
        if sexFilter != nil {
            let sexPredicate = NSPredicate(format: "sex CONTAINS[cd] %@", sexFilter!)
            predicateArray.append(sexPredicate)
        }
        if activityFilter != nil {
            let activityPredicate = NSPredicate(format: "activity CONTAINS %@", activityFilter!)
            predicateArray.append(activityPredicate)
        }
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        instructorArray = instructorArray?.filter(compound).sorted(byKeyPath: "username", ascending: true)
        
        
        tableView.reloadData()
        
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
           return instructorArray?.count ?? 1
       }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.instructorCell, for: indexPath) as! InstructorChoiceCell
        cell.profileNameLabel.text = (instructorArray?[indexPath.row] ?? defaultInstructor as User).username
        
        return cell
    }
       
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.instructor = instructorArray![indexPath.row]
            
               
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: K.searchSegueInstructor, sender: self)
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
            destinationVC.instructor = self.instructor
        }

    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 0 {
            loadInstructors(searchBar.text!)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadInstructors(searchText)
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

