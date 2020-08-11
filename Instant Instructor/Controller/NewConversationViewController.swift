//
//  NewMessageViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/4/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import RealmSwift

class NewConversationViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var instructorArray : Results<Instructor>? = nil
    var conversation : Conversation? = nil
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.messageChoiceCellNib, bundle: nil), forCellReuseIdentifier: K.messageChoiceCell)
        searchBar.delegate = self
        loadInstructors()
    }
    func loadInstructors() {
        instructorArray = realm.objects(Instructor.self)
        
    }
    @IBAction func filtersButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.newMessageSegueFilters, sender: self)
    }
    
    func saveConversation(_ conversation: Conversation) {
        do {
            try realm.write {
                realm.add(conversation)
            }
        } catch {
            print("Error saving conversation, \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.newMessageSegueFilters {
        _ = segue.destination as! SearchFilterViewController
        }
            
        if segue.identifier == K.newMessageSegueMessages {
            let destinationVC = segue.destination as! MessageViewController
            destinationVC.parentConversation = self.conversation
        }
    }
    
//MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructorArray!.count
    }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageChoiceCell, for: indexPath) as! MessageChoiceCell
           
        cell.profileNameLabel.text = (instructorArray![indexPath.row] as GeneralAccount).username
           
        return cell
    }
       
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instructor = instructorArray![indexPath.row]
        let newConversation = Conversation()
        newConversation.participants.append(instructor)
        //append the current user as a participant by searching for the current user by their email
        self.conversation = newConversation
        saveConversation(newConversation)
        self.performSegue(withIdentifier: K.newMessageSegueMessages, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    
    }
    

}

//MARK: - UITextFieldDelegate

extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadInstructors()
    }
}
