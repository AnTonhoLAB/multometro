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
    
    @IBOutlet weak var tfName: UITextField! {
        didSet{
            tfName.textAlignment = .center
            tfName.placeholder = R.string.localizable.placeholderUsername()
        }
    }
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
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
    
        guard let name = tfName.text,
            let email = tfEmail.text,
            let password = tfPassword.text,
            let confirmPassword = tfConfirmPassoword.text else { return }
        
        let userRegister = UserRegisterViewModel(name: name, email: email, password: password, confirmPassword: confirmPassword)
        
        do {
            try userRegister.validate()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
