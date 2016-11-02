//
//  ProfileViewController.swift
//  Spex
//
//  Created by iMac on 11/1/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, MenuTransitionManagerDelegate {
    
    let menuTransitionManager = MenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDefaults.standard.value(forKey: KEY_UID) == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController = storyboard.instantiateViewController(withIdentifier: "signInViewControllerID") as! SignInViewController
            self.present(signInViewController, animated: false, completion: nil)
        }
    }
    
    

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let settingsVC = segue.source as! SettingsProfileTableViewController
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuTableViewController = segue.destination as! SettingsProfileTableViewController
        //menuTableViewController.currentItem = self.title!
        menuTableViewController.transitioningDelegate = menuTransitionManager
        menuTransitionManager.delegate = self
    }
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    func backToSignInVC() {
        
        self.dismiss(animated: true, completion: nil)
        
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
