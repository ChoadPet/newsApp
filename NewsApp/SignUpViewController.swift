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
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        warningLbl.isHidden = true
        emailField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        confirmPasswordField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        
        signUpButton.layer.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.33, alpha:1.0).cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text, let confirmPassword = confirmPasswordField.text {
            if confirmPassword == password {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error != nil {
                        if let errorMessage = error?.localizedDescription {
                            self.warningLbl.isHidden = false
                            self.warningLbl.backgroundColor = UIColor(red:0.81, green:0.22, blue:0.02, alpha:1.0)
                            self.warningLbl.text = errorMessage
                        }
                    }
                    if user != nil {
                        self.warningLbl.isHidden = true
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                }
            } else {
                self.warningLbl.isHidden = false
                self.warningLbl.backgroundColor = UIColor(red:0.81, green:0.22, blue:0.02, alpha:1.0)
                self.warningLbl.text = "Password not match!"
            }
        } else {
            self.warningLbl.isHidden = false
            self.warningLbl.backgroundColor = UIColor(red:0.81, green:0.22, blue:0.02, alpha:1.0)
            self.warningLbl.text = "Empty fields"
        }
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}
