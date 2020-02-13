//
//  LoginViewController.swift
//  Multometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginFlowDelegate: class {
    func onLogin()
    func onRegister()
    func onChangePassword()
}

class LoginViewController: UpdatableViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    private var loginView: LoginViewComponents!
    private var viewModel: LoginViewModel!

    weak var flowDelegate: LoginFlowDelegate?

    override func loadView() {
        self.view = loginView
    }

    init(with view: LoginView, and viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.loginView = view
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let inputs = LoginViewModel.Input(name: self.loginView!.emailObservable,
                                          password: self.loginView.passwordObservable,
                                          didTapLogin: self.loginView.enterObservable)

        let outputs = viewModel.transform(input: inputs)

        outputs.isValid
            .drive(self.loginView.enterIsValide)
            .disposed(by: disposeBag)

//        outputs.networkingStatus
//            .drive(onNext: { (response) in
//            print(response)
//        }, onCompleted: {
//            print("completo")
//        }) {
//            print("Disposado")
//        }
//        .disposed(by: disposeBag)

        outputs.networkingStatus.subscribe(self.rx.netState)


//        outputs.networkingStatus
//            .drive(self.rx.netState)
//            .disposed(by: disposeBag)
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
}
