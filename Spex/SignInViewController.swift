//
//  SignInViewController.swift
//  Spex
//
//  Created by iMac on 10/31/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAssets()
        
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        NotificationCenter.default.addObserver(self, selector:#selector(SignInViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        introAnimation()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    
    func configureAssets() {
        
        self.titleLabel.alpha = 0.0
        self.usernameTextField.alpha = 0.0
        self.passwordTextField.alpha = 0.0
        
        self.signInButton.isHidden = true
        self.signInButton.center.y += self.signInButton.frame.height
        
        self.signUpButton.alpha = 0.0
        
        self.usernameTextField.center.y += -20
        self.passwordTextField.center.y += -20
        self.titleLabel.center.y += -20
        
    }
    func fadeInAssets() {
        
        self.titleLabel.alpha = 1.0
        self.signUpButton.alpha = 1.0
    
    }
    func fadeInTextFields() {
        
        self.usernameTextField.alpha = 1.0
        self.passwordTextField.alpha = 1.0
        
    }
    func animateTitleLabel() {
        
        self.titleLabel.center.y -= -20
        
    }
    
    func animateTextFields() {
        
        self.usernameTextField.center.y -= -20
        self.passwordTextField.center.y -= -20
        
    }
    
    func introAnimation() {
        
        UIView.animate(withDuration: 2.0, delay: 0.7, options: .curveEaseOut, animations: {
            
           self.fadeInAssets()
            self.animateTitleLabel()
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 1.5, options: .curveEaseOut, animations: {
            self.fadeInTextFields()
            self.animateTextFields()
            
        }, completion: nil)
    }
    
    func ShowSignInButton() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.signInButton.isHidden = false
            self.signInButton.center.y -= self.signInButton.frame.height
            
        }, completion: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                self.bottomLayoutConstraint.constant = keyboardSize.height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        self.bottomLayoutConstraint.constant = 0
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            
            self.ShowSignInButton()
            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
