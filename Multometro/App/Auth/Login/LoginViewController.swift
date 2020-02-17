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

    init(with view: LoginView, and viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.loginView = view
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let inputs = LoginViewModel.Input(name: loginView.emailObservable,
                                          password: loginView.passwordObservable,
                                          didTapLogin: loginView.enterObservable,
                                          didTapRegister: loginView.didTapRegister)

        let outputs = viewModel.transform(input: inputs)

        outputs.isValid
            .drive(loginView.enterIsValide)
            .disposed(by: disposeBag)

        outputs.networkingStatus
            .map({ (state) -> NetworkingState<Any> in
                state.toAny()
            })
            .drive(rx.loadingState)
            .disposed(by: disposeBag)

        outputs.networkingStatus
            .drive(onNext: { (status) in
                switch status {
                case .loading:
                    break
                case .success(_):
                    self.flowDelegate?.onLogin()
                case .fail(_):
                    break
                case .default:
                    break
                }
            })
            .disposed(by: disposeBag)

        outputs.openRegister
            .drive(onNext: { (_) in
                self.flowDelegate?.onRegister()
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
