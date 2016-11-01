//
//  SignUpViewController.swift
//  Spex
//
//  Created by iMac on 10/31/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAssets()
        
        emailTextField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        NotificationCenter.default.addObserver(self, selector:#selector(SignUpViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        introAnimation()
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        configureAssets()
    }
   
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        
        
    }
    @IBAction func signInBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func configureAssets() {
        
        self.titleLabel.alpha = 0.0
        self.emailTextField.alpha = 0.0
        self.passwordField.alpha = 0.0
        self.confirmPasswordField.alpha = 0.0
        
        self.signUpButton.isHidden = true
        self.signUpButton.center.y += self.signUpButton.frame.height
        
        self.signInBtn.alpha = 0.0
        
        self.emailTextField.center.y += -20
        self.passwordField.center.y += -20
        self.confirmPasswordField.center.y += -20
        self.titleLabel.center.y += -20
        
    }

    func fadeInAssets() {
        
        self.titleLabel.alpha = 1.0
        
        
    }
    func fadeInButtons() {
        self.signInBtn.alpha = 1.0
        
    }
    func animateTitleLabel() {
        
        self.titleLabel.center.y -= -20
        
    }
    func fadeInTextFields() {
        
        self.emailTextField.alpha = 1.0
        self.passwordField.alpha = 1.0
        self.confirmPasswordField.alpha = 1.0
        
    }
    func animateTextFields() {
        
        self.emailTextField.center.y -= -20
        self.passwordField.center.y -= -20
        self.confirmPasswordField.center.y -= -20
        
    }
    func introAnimation() {
        
        UIView.animate(withDuration: 2.0, delay: 0.7, options: .curveEaseOut, animations: {
            
            self.fadeInAssets()
            self.fadeInButtons()
            
            self.animateTitleLabel()
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 1.5, options: .curveEaseOut, animations: {
            self.fadeInTextFields()
            self.animateTextFields()
            
        }, completion: nil)
    }
    
    func fadeOutButtons() {
        
        self.signInBtn.alpha = 0.0
        
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
        if self.signInBtn.alpha != 0.0 {
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.fadeOutButtons()
            }, completion: nil)
            
        }
        
        if textField.tag == 1 {
            
            self.ShowSignUpButton()
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.signInBtn.alpha == 0.0{
            
            UIView.animate(withDuration: 1.0, delay: 0.4, options: .curveEaseOut, animations: {
                self.fadeInButtons()
            }, completion: nil)
        }
        
        self.view.endEditing(true)
        return false
    }
    
    func ShowSignUpButton() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.signUpButton.isHidden = false
            self.signUpButton.center.y -= self.signUpButton.frame.height
            
        }, completion: nil)
        
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
