//
//  LoginVC.swift
//  BaseArchitecture
//
//  Created by Ashutosh Mishra on 30/08/18.
//  Copyright © 2018 i2e1. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var viewModel : LoginVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginVM()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        viewModel?.performSignInForCredentials(mobile: "9990377763", appId: "abcd", mac: "40:4D:7F:7F:0E:54", completionHandler: { (message) in
            LoggerClass.logDebug(method: "loginBtnClick", message: message!)
        })
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
