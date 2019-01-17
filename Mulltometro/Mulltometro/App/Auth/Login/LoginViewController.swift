//
//  LoginViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var constraintToBot: NSLayoutConstraint!
    
    @IBOutlet weak var fieldsView: UIView! {
        didSet {
            fieldsView.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btEnter: UIButton! {
        didSet {
            btEnter.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet weak var btRegister: UIButton! {
        didSet {
            btRegister.roundedCornerColor(radius: roundRadius)
        }
    }
    
    private let roundRadius: CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btLogin(_ sender: Any) {
        guard let tfEmail = tfEmail.text, let tfPassword = tfPassword.text else { return }
        login(email: tfEmail, password: tfPassword)
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    func login(email: String, password: String) {
        showLoader()
        AuthManager.login(email: email, password: password) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .success(let user):
                UserRequester.saveLocally(user: user)
                if user.firstTime == false {
                    self.openApp()
                } else {
                    self.openOnboarding()
                }
            case .failure(let err):
                self.alertSimpleWarning(title: "Error", message: err.localizedDescription, action: nil)
                self.dismissLoader()
            }
        }
    }
    
    func openOnboarding() {
        DispatchQueue.main.sync {
            guard let window = UIApplication.shared.keyWindow else { return }
            let retisterUserStoryboard: UIStoryboard = R.storyboard.registerUser()
            let viewController = retisterUserStoryboard.instantiateViewController(withIdentifier : "RegisterUserViewController")
            
            UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            }, completion: nil)
        }
    }
    
    func openApp() {
    
        guard let window = UIApplication.shared.keyWindow else { return }
        let mainStoryboard: UIStoryboard = R.storyboard.main()
        guard let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: R.string.strings.mainIdentifier()) as? UITabBarController else { return }

        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        })
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
}

