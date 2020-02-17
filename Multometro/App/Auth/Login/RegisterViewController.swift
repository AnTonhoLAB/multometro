//
//  RegisterViewController.swift
//  Multometro
//
//  Created by George Gomes on 16/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift
import RxSwift

class RegisterViewController: UIViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    private var registerView: RegisterViewComponents!
    private var viewModel: RegisterViewModel!

    weak var flowDelegate: LoginFlowDelegate?

    init(with view: RegisterView, and viewModel: RegisterViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.registerView = view
        self.viewModel = viewModel
    }

    override func loadView() {
        self.view = registerView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        showLoader()
//        guard let email = tfEmail.text,
//            let password = tfPassword.text,
//            let confirmPassword = tfConfirmPassoword.text else { return }
//
//        let userRegister = UserRegisterViewModel(email: email, password: password, confirmPassword: confirmPassword)
//
//        do {
//            try userRegister.validate()
//            AuthManager.createUser(with: email, password: password) { [weak self] res in
//                guard let self = self else { return }
//                switch res {
//                case .success(_):
//                    self.finishRegister()
//                case .failure(let error):
//                    self.errorRegister(error: error)
//                }
//                self.dismissLoader()
//            }
//        } catch {
//            errorRegister(error: error)
//        }
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
         self.dismissLoader()
         alertSimpleMessage(message: error.localizedDescription)
    }
    
    func unwindToLogin() {
        self.performSegue(withIdentifier: R.segue.registerViewController.unwindToLogin.identifier, sender: nil)
    }
}
