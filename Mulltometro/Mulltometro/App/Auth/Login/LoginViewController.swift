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
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @IBAction func btLogin(_ sender: Any) {
        guard let tfEmail = tfEmail.text, let tfPassword = tfPassword.text else { return }

        self.showLoader()
        AuthManager.login(user: tfEmail, password: tfPassword) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .success(_):
                self.checkUser()
            case .failure(let err):
                self.alertSimpleWarning(title: "Error", message: err.localizedDescription, action: nil)
                self.dismissLoader()
            }
        }
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    func checkUser() {
        UserRequester.checkUser { isFirstTimeInApp in
            guard let window = UIApplication.shared.keyWindow else { return }
            self.dismissLoader()
            if isFirstTimeInApp {
                
                let retisterUserStoryboard: UIStoryboard = R.storyboard.registerUser()
                let viewController = retisterUserStoryboard.instantiateViewController(withIdentifier : "RegisterUserViewController")
                
                UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = viewController
                }, completion: nil)
            } else {
              self.openApp()
            }
        }
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

extension LoginViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        let sizeToKeyboard = view.frame.maxY - fieldsView.frame.maxY
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyBoardheight = keyboardSize.height
            UIView.animate(withDuration: 0.8) { [weak self] in
                guard let self = self else { return }
                let constant = (sizeToKeyboard - keyBoardheight)
                self.constraintToBot.constant = Swift.abs(constant) + 40
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.8) { [weak self] in
            guard let self = self else { return }
            self.constraintToBot.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

