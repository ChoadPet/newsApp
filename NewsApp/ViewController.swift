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
    @IBOutlet weak var warningLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        warningLbl.isHidden = true
        
        emailField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        
        newAccountButton.layer.borderWidth = 1
        newAccountButton.layer.borderColor = UIColor.black.cgColor
        signInButton.layer.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.33, alpha:1.0).cgColor
        
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if error != nil {
                        if let errorMessage = error?.localizedDescription {
                            self.warningLbl.isHidden = false
                            self.warningLbl.text = errorMessage
                            self.warningLbl.backgroundColor = UIColor(red:0.81, green:0.22, blue:0.02, alpha:1.0)
                        }
                    }
                    if user != nil {
                        self.warningLbl.isHidden = true
                        self.performSegue(withIdentifier: "goToHomeScreen", sender: self)
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}


