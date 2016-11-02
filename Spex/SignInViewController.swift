//
//  SignInViewController.swift
//  Spex
//
//  Created by iMac on 10/31/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import JSSAlertView


class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var facebookLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAssets()
        
        passwordTextField.delegate = self
        usernameTextField.delegate = self
            
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if UserDefaults.standard.value(forKey: KEY_UID) != nil {
            
            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
            
        }
        
        NotificationCenter.default.addObserver(self, selector:#selector(SignInViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        introAnimation()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        configureAssets()
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if let email = usernameTextField.text, email != "", let pwd = passwordTextField.text, pwd != "" {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (User, error) in
                
                if error != nil {
                    
                    let errorString: String = error!.localizedDescription
                    print(errorString)
                    if errorString == STATUS_ACCOUNT_NONEXIST {
                        self.showAlertWithTwoButtons(titleAlert: "User Not Found", textAlert: "Would you like to create an account?", buttonTextAlert: "OK", cancelButtonTextAlert: "Cancel", colorAlert: COLOR_WAX_FLOWER)
                        print("the account doesnt exist-------------->")
                    } else if errorString == STATUS_EMAIL_FORMAT{
                        self.showAlertWithOneButton(titleAlert: "Problem With Email", textAlert: "Please Enter A Valid Email", buttonTextAlert: "Try Again", colorAlert: COLOR_WAX_FLOWER)
                        print("please enter a valid email address-------------->")
                        
                    } else {
                        self.showAlertWithOneButton(titleAlert: "Incorrect!", textAlert: "Incorrect Email Or Password", buttonTextAlert: "Try Again", colorAlert: COLOR_WAX_FLOWER)
                    }
                    
                } else {
                    
                    UserDefaults.standard.set(User?.uid, forKey: KEY_UID)
                    self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                    
                }
            })
        } else {
            
            print("email and password required")
            showAlertWithOneButton(titleAlert: "Missing Fields!", textAlert: "Email & Password Required.", buttonTextAlert: "Try Again", colorAlert: COLOR_WAX_FLOWER)
            
        }
        
    }
    
    func showAlertWithTwoButtons(titleAlert: String, textAlert: String, buttonTextAlert: String, cancelButtonTextAlert: String, colorAlert: UIColor) {
        
        let alertview = JSSAlertView().show(
            self,
            title: titleAlert,
            text: textAlert,
            buttonText: buttonTextAlert,
            cancelButtonText: cancelButtonTextAlert,
            color: colorAlert
        )
        alertview.setButtonFont("Avenir-Light")
        alertview.setTextFont("Avenir-Light")
        alertview.setTitleFont("Avenir-Light")
        alertview.setTextTheme(.light)
        alertview.addAction(self.goToSignUp)
        
    }
    func showAlertWithOneButton(titleAlert: String, textAlert: String, buttonTextAlert: String, colorAlert: UIColor){
        
        let alertview = JSSAlertView().show(
            self,
            title: titleAlert,
            text: textAlert,
            buttonText: buttonTextAlert,
            color: colorAlert
        )
        alertview.setButtonFont("Avenir-Light")
        alertview.setTextFont("Avenir-Light")
        alertview.setTitleFont("Avenir-Light")
        alertview.setTextTheme(.light)
        
    }
    
    func goToSignUp() {
        
        self.performSegue(withIdentifier: SEGUE_TO_SIGN_UP_PAGE, sender: nil)
        
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) -> Void in
            
            if error != nil {
                
                print("facebook login failed. Error \(error)")
                self.showAlertWithOneButton(titleAlert: "Failed", textAlert: "Facebook Login Failed", buttonTextAlert: "OK", colorAlert: COLOR_WAX_FLOWER)
                
            } else if result!.isCancelled {
                 print("FBLogin cancelled")
                
            } else {
                
                let accessToken = FBSDKAccessToken.current().tokenString
                print("successful fb login \(accessToken)")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken!)
                
                self.firebaseLogin(credential)
                
            }
        })
    }
    
    func firebaseLogin(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil{
                
                self.showAlertWithOneButton(titleAlert: "Failed", textAlert: "Facebook Login Failed", buttonTextAlert: "OK", colorAlert: COLOR_WAX_FLOWER)
                
                
            } else {
                
                print("Logged In!")
                UserDefaults.standard.set(user?.uid, forKey: KEY_UID)
                self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
            }
        }
    }
    
    func configureAssets() {
        
        self.titleLabel.alpha = 0.0
        self.usernameTextField.alpha = 0.0
        self.passwordTextField.alpha = 0.0
        
        self.signInButton.isHidden = true
        self.signInButton.center.y += self.signInButton.frame.height
        
        self.fadeOutButtons()
        
        self.usernameTextField.center.y += -20
        self.passwordTextField.center.y += -20
        self.titleLabel.center.y += -20
        
    }
    func fadeInAssets() {
        
        self.titleLabel.alpha = 1.0
        
    
    }
    func fadeInButtons() {
        self.signUpButton.alpha = 1.0
        self.facebookLoginBtn.alpha = 1.0
        
    }
    func fadeOutButtons() {
        
        self.signUpButton.alpha = 0.0
        self.facebookLoginBtn.alpha = 0.0
        
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
            self.fadeInButtons()
            
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
        if self.facebookLoginBtn.alpha != 0.0  && self.signUpButton.alpha != 0.0{
        
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.fadeOutButtons()
            }, completion: nil)
            
        }
        
        if textField.tag == 1 {
            
            self.ShowSignInButton()
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.facebookLoginBtn.alpha == 0.0  && self.signUpButton.alpha == 0.0{
            
            UIView.animate(withDuration: 1.0, delay: 0.4, options: .curveEaseOut, animations: {
                self.fadeInButtons()
            }, completion: nil)
        }
        
        self.view.endEditing(true)
        return false
    }
}
