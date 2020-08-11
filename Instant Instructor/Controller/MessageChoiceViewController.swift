//
//  MessageChoiceViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/3/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift

class MessageChoiceViewController: UITableViewController {
    
    var conversation : Conversation? = nil
    var conversationArray : Results<Conversation>? = nil
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.messageChoiceCellNib, bundle: nil), forCellReuseIdentifier: K.messageChoiceCell)
        loadConversations()
    }
    
    func loadConversations() {
        conversationArray = realm.objects(Conversation.self)
    }
    @IBAction func newMessageButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: K.messageChoiceSegueNewMessage, sender: self)
    }
    
    func getOtherParticipants(_ conversation: Conversation) -> String {
        let participants = conversation.participants
        var otherParticipants = ""
        for participant in participants {
            if participant.email != Auth.auth().currentUser?.email {
                otherParticipants = otherParticipants +  participant.username!
            }
        }
        return otherParticipants
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationArray!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageChoiceCell, for: indexPath) as! MessageChoiceCell
        
        let conversation = conversationArray![indexPath.row]
        cell.profileNameLabel.text = getOtherParticipants(conversation)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversationArray![indexPath.row]
        self.conversation = conversation
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.messageChoiceSegueMessages, sender: self)
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.messageChoiceSegueMessages {
            let destinationVC = segue.destination as! MessageViewController
            destinationVC.parentConversation = self.conversation
        }
    }
}
