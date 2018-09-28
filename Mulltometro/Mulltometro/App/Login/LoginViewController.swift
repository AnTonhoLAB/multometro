//
//  LoginViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func btLogin(_ sender: Any) {
        guard let tfEmail = tfEmail.text, let tfPassword = tfPassword.text else { return }
        
        AuthManager.login(user: tfEmail, password: tfPassword) {
            switch $0 {
            case .success(let user):
                guard let usser = user as? AuthDataResult else { return }
                
           
                
                
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
