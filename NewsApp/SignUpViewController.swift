//
//  SignUpViewController.swift
//  NewsApp
//
//  Created by Vitalii Poltavets on 12/15/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text, let confirmPassword = confirmPasswordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let newUser = user {
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                } else {
                    print("some problem")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
