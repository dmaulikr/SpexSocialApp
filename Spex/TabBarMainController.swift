//
//  TabBarMainController.swift
//  Spex
//
//  Created by iMac on 11/1/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class TabBarMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //let signInVC = SignInViewController()
        //self.present(signInVC, animated: false, completion: {})
        //self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        //print("---------------------")
        
//        if UserDefaults.standard.value(forKey: KEY_UID) == nil {
//            
//            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
//            
//        }
        
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
