//
//  MessageChoiceViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/3/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

class MessageChoiceViewController: UITableViewController {

    let messageSenderArray = ["Bob The Builder", "Nathaniel Bacon", "Kendrick Lamar"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: K.messageChoiceCellNib, bundle: nil), forCellReuseIdentifier: K.messageChoiceCell)
    }
    
    @IBAction func newMessageButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: K.messageChoiceSegueNewMessage, sender: self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageSenderArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageChoiceCell, for: indexPath) as! MessageChoiceCell
        
        cell.profileNameLabel.text = messageSenderArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageSender = messageSenderArray[indexPath.row]
        print(messageSender)
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: K.messageChoiceSegueMessages, sender: self)
 
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.messageChoiceSegueMessages {
            _ = segue.destination as! MessageViewController
        }
    }
}
