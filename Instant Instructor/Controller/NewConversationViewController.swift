//
//  NewMessageViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/4/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class NewConversationViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var instructorArray : [User]?
    var conversation : Conversation?
    var activityFilter: String?
    var sexFilter: String?
    @IBOutlet weak var tableView: UITableView!
    var users : [User]?
    var currentUsername: String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.messageChoiceCellNib, bundle: nil), forCellReuseIdentifier: K.messageChoiceCell)
        searchBar.delegate = self
        //read just prints, store stuff in instructorArray
        FirestoreService.shared.read(from: .User, returning: User.self) { (users) in
            self.users = users
        }
        tableView.reloadData()
    }
    
    
    @IBAction func filtersButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.newMessageSegueFilters, sender: self)
    }
    func query(searchText: String, sex: String, activity: String ) {
        //use filters to adjust instructorArray
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.newMessageSegueFilters {
        let destinationVC = segue.destination as! ConversationFiltersViewController
            
        destinationVC.previousVC = self
        }
            
        if segue.identifier == K.newMessageSegueMessages {
            let destinationVC = segue.destination as! MessageViewController
            destinationVC.parentConversation = self.conversation
        }
    }
    
    

}

//MARK: - UITextFieldDelegate

extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query(searchText: searchText, sex: sexFilter ?? "", activity: activityFilter ?? "")
    }
}


//MARK: - UITableViewDataSource
    
extension NewConversationViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructorArray?.count ?? 1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageChoiceCell, for: indexPath) as! MessageChoiceCell
           
        cell.profileNameLabel.text = instructorArray?[indexPath.row].username
           
        return cell
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if instructorArray != nil {
            let instructor = instructorArray![indexPath.row]
            //use the correct  sender username
            db.collection("User").whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.currentUsername = document.decode(as: User.self)?.username
                            print(self.currentUsername as Any)
                        }
                    }
            }
            let newConversation = Conversation(senderUsername: currentUsername ?? "", recipientUsername: instructor.username)
            conversation = newConversation
            FirestoreService.shared.create(for: newConversation, to: .Conversation)
            tableView.reloadData()
            performSegue(withIdentifier: K.newMessageSegueMessages, sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
