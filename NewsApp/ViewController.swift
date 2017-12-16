//
//  ViewController.swift
//  NewsApp
//
//  Created by Vitalii Poltavets on 12/15/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var newAccountButton: UIButton!
    
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let existUser = user {
                    self.performSegue(withIdentifier: "goToHomeScreen", sender: self)
                } else {
                    print("User not found in DB")
                }
            }

        } else {
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

