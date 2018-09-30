//
//  LoginViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btLogin(_ sender: Any) {
        guard let tfEmail = tfEmail.text, let tfPassword = tfPassword.text else { return }

       
        AuthManager.login(user: tfEmail, password: tfPassword) { [weak self] in
            switch $0 {
            case .success(_):
                guard let self = self else { return }
                self.openApp()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func openApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let rootController = R.storyboard.main().instantiateViewController(withIdentifier: "MainViewController")
        window.rootViewController = rootController
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = rootController
        }, completion: nil)
    }
    
}
