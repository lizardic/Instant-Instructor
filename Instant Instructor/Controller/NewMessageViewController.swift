//
//  NewMessageViewController.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 8/4/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

class NewMessageViewController: UITableViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let messageSenderArray = ["Bob The Builder", "Nathaniel Bacon", "Kendrick Lamar"]
       override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
           tableView.register(UINib(nibName: K.messageChoiceCellNib, bundle: nil), forCellReuseIdentifier: K.messageChoiceCell)
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UITextFieldDelegate

extension NewMessageViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)

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
