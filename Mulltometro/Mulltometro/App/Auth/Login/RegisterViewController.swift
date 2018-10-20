//
//  RegisterViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 16/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField! {
        didSet{
            tfEmail.textAlignment = .center
            tfEmail.placeholder = R.string.localizable.placeholderEmail()
        }
    }
    @IBOutlet weak var tfPassword: UITextField! {
        didSet{
            tfPassword.textAlignment = .center
            tfPassword.placeholder = R.string.localizable.placeholderPassowrd()
        }
    }
    @IBOutlet weak var tfConfirmPassoword: UITextField! {
        didSet{
            tfConfirmPassoword.textAlignment = .center
            tfConfirmPassoword.placeholder = R.string.localizable.placeholderRepeatPassword()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
    
        guard let email = tfEmail.text,
            let password = tfPassword.text,
            let confirmPassword = tfConfirmPassoword.text else { return }
        
        let userRegister = UserRegisterViewModel(email: email, password: password, confirmPassword: confirmPassword)
        
        do {
            try userRegister.validate()
            AuthManager.createUser(with: email, password: password) { [weak self] res in
                guard let self = self else { return }
                switch res {
                case .success(_):
                    self.finishRegister()
                case .failure(let error):
                    self.errorRegister(error: error)
                }
            }
        } catch {
            errorRegister(error: error)
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        unwindToLogin()
    }
    
    func finishRegister() {
        alertSimpleMessage(message: R.string.localizable.registerSucess()) { [weak self] _ in
            guard let self = self else { return }
            self.unwindToLogin()
        }
    }
    
    func errorRegister(error: Error){
         alertSimpleMessage(message: error.localizedDescription)
    }
    
    func unwindToLogin() {
        self.performSegue(withIdentifier: R.segue.registerViewController.unwindToLogin.identifier, sender: nil)
    }
}