//
//  AuthForm.swift
//  Multometro
//
//  Created by George Gomes on 17/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

enum AuthStep {
    case login
    case register
    case forgotPassword
}

class AuthFormView: UIView {

    private var authStep: AuthStep

    //MARK: - Observable Components
    lazy var emailObservable: Observable<String> = {
        return self.emailTextField.rx.text.orEmpty.asObservable()
    }()

    lazy var passwordObservable: Observable<String> = {
       return self.passwordTextField.rx.text.orEmpty.asObservable()
    }()

    lazy var repeatPasswordObservable: Observable<String> = {
       return self.repeatPasswordTextField.rx.text.orEmpty.asObservable()
    }()

    lazy var enterObservable: Observable<Void> = {
       return self.enterButton.rx.tap.asObservable()
    }()

    lazy var enterIsValide: Binder<Bool> = {
       return  self.enterButton.rx.valid
    }()

    init(authStep: AuthStep) {
        self.authStep = authStep
        super.init(frame: .zero)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.borderStyle = .roundedRect
        view.placeholder = R.string.localizable.placeholderEmail()
        view.textAlignment = .center
        return view
    }()

    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.borderStyle = .roundedRect
        view.placeholder = R.string.localizable.placeholderPassword()
        view.textAlignment = .center
        return view
    }()

    private lazy var repeatPasswordTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.borderStyle = .roundedRect
        view.placeholder = R.string.localizable.placeholderPassword()
        view.textAlignment = .center
        return view
    }()

    private lazy var enterButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .red
        view.setTitle(R.string.localizable.login(), for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.7967856526, green: 0.2607563436, blue: 0.1506694257, alpha: 1)
        view.roundedCornerColor(radius: 2)
        return view
   }()
}

extension AuthFormView: CodeView {
    func buildViewHierarchy() {
        addSubview(emailTextField)
        addSubview(enterButton)

        switch authStep {
        case .login:
            addSubview(passwordTextField)
        case .register:
            addSubview(passwordTextField)
            addSubview(repeatPasswordTextField)
        default:
            break
        }
    }

    func setupConstraints() {
        ///
        emailTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }

        enterButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(emailTextField)
            make.right.equalTo(emailTextField)
            make.bottom.equalTo(self.snp.bottom).inset(14)
        }

        switch authStep {
        case .login:
            makePasswordTextFieldConstraint()

            enterButton.snp.makeConstraints { (make) in
                make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            }

        case .register:
            makePasswordTextFieldConstraint()

            repeatPasswordTextField.snp.makeConstraints { (make) in
                make.height.equalTo(emailTextField)
                make.top.equalTo(passwordTextField.snp.bottom).offset(18)
                make.left.equalTo(emailTextField)
                make.right.equalTo(emailTextField)
            }

            enterButton.snp.makeConstraints { (make) in
                make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(20)
            }
        case .forgotPassword:
            enterButton.snp.makeConstraints { (make) in
                make.top.equalTo(emailTextField.snp.bottom).offset(20)
            }
        }
    }

    private func makePasswordTextFieldConstraint() {
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(18)
            make.left.equalTo(emailTextField)
            make.right.equalTo(emailTextField)
        }
    }

    func setupAdditionalConfiguration() {

    }
}
