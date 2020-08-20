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

class MessageViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    var messages: [Message]?
    var parentConversation: Conversation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.messageCellNib, bundle: nil), forCellReuseIdentifier: K.messageCell)
        //read simply prints, should store values in messages
        FirestoreService.shared.read(from: .Message, returning: Message.self) { (messages) in
            self.messages = messages
        }
        tableView.reloadData()
        
        
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
        if let messageBody = messageTextField.text {
            let newMessage = Message(senderUsername: parentConversation?.senderUsername ?? "", recipientUsername: parentConversation?.recipientUsername ?? "", body: messageBody, date: Date())
            FirestoreService.shared.create(for: newMessage, to: .Message)
            //read simply prints atm, should update messages
            FirestoreService.shared.read(from: .Message, returning: Message.self) { (messages) in
                self.messages = messages
                self.tableView.reloadData()
            }
        }
        messageTextField.text = ""
        
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
    
        return cell
   }
}
//MARK: - UITableViewDelegate
extension MessageViewController: UITableViewDelegate {
    
}
