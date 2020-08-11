//
//  MessageViewController.swift
//  Find A Coach
//
//  Created by Christian Lizardi on 7/18/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift

class MessageViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var messages: Results<Message>? = nil
    var parentConversation: Conversation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.messageCellNib, bundle: nil), forCellReuseIdentifier: K.messageCell)
        
        
        navigationBar.title = getOtherParticipants(parentConversation!)
        
        loadMessages()
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
    
    func loadMessages() {
        messages = realm.objects(Message.self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

//MARK: - UITextFieldDelegate
extension MessageViewController: UITextFieldDelegate {
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        messageTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use the textfield.text to do whatever you need
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            let newMessage = Message()
            newMessage.body = messageBody
            newMessage.sender = messageSender
            saveMessage(newMessage)
        }
        messageTextField.text = ""
        loadMessages()
    }
    func saveMessage(_ message: Message) {
        do {
            try realm.write {
                realm.add(message)
            }
        } catch {
            print("Error saving message, \(error)")
        }
    }
}

//MARK: - UITableViewDataSource
extension MessageViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messages!.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageCell, for: indexPath) as! MessageCell
        cell.label.text = message.body
        cell.leftImageView.isHidden = true
        cell.leftFillerImageView.isHidden = false
        cell.rightImageView.isHidden = true
//      ADJUSTING CELL LOOK BASED ON WHO SENT IT
//        if message.sender == Auth.auth().currentUser?.email {
//            cell.leftImageView.isHidden = true
//            cell.leftFillerImageView.isHidden = false
//            cell.rightImageView.isHidden = true
//        } else {
//            cell.leftImageView.isHidden = false
//            cell.leftFillerImageView.isHidden = true
//            cell.rightImageView.isHidden = false
//            cell.messageBubble.backgroundColor = UIColor(named: "BrandDarkGray")
//        }

        return cell 
   }
}
//MARK: - UITableViewDelegate
extension MessageViewController: UITableViewDelegate {
    
}
