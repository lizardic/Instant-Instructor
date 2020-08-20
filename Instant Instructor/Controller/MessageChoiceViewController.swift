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
import SwipeCellKit

class MessageChoiceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var conversation : Conversation?
    var conversationArray : [Conversation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirestoreService.shared.read(from: .Conversation, returning: Conversation.self) { (conversations) in
            self.conversationArray = conversations
        }
        tableView.register(UINib(nibName: K.messageChoiceCellNib, bundle: nil), forCellReuseIdentifier: K.messageChoiceCell)
        tableView.reloadData()
    }

    
    @IBAction func newMessageButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: K.messageChoiceSegueNewMessage, sender: self)
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.messageChoiceSegueMessages {
            let destinationVC = segue.destination as! MessageViewController
            destinationVC.parentConversation = self.conversation
        }
    }
}

extension MessageChoiceViewController: UITableViewDataSource {
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return conversationArray?.count ?? 0
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageChoiceCell, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
           
           return cell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if conversationArray != nil {
               let conversation = conversationArray![indexPath.row]
               self.conversation = conversation
               tableView.deselectRow(at: indexPath, animated: true)
               self.performSegue(withIdentifier: K.messageChoiceSegueMessages, sender: self)
           }
    
       }
    func tableView(_ tableView: UITableView, commit commitEditingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard commitEditingStyle == .delete else {return}
    }
}

extension MessageChoiceViewController: UITableViewDelegate {
    
}

extension MessageChoiceViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            let deletedConversation = self.conversationArray![indexPath.row]
            do {
                try FirestoreService.shared.delete(deletedConversation, in: .Conversation)
                tableView.reloadData()
            } catch {
                print("Error deleting, \(error)")
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    
}
