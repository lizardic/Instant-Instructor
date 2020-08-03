//
//  ScheduleViewController.swift
//  Find A Coach
//
//  Created by Christian Lizardi on 7/18/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var scheduleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "scheduleToFind", sender: self)
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "scheduleToMessage", sender: self)
        
    }
    @IBAction func scheduleButtonPressed(_ sender: UIButton) {
        print("already on this page")
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
        if segue.identifier == "scheduleToFind" {
            _ = segue.destination as! SearchViewController
        }
        if segue.identifier == "scheduleToMessage" {
            _ = segue.destination as! MessageViewController
        }
        
    }

}
