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
            guard let self = self else { return }
            
            switch $0 {
            case .success(_):
                self.openApp()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    func openApp() {
        guard let window = UIApplication.shared.keyWindow else { return }

        let mainStoryboard: UIStoryboard = R.storyboard.main()
        guard let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: R.string.strings.mainIdentifier()) as? UITabBarController else { return }
        window.rootViewController = tabBarController
        
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        }, completion: nil)
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }

}
