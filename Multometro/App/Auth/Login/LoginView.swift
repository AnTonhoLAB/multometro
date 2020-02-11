//
//  LoginView.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit

protocol LoginViewComponents {

}

class LoginView: UIView, CodeView {

    //MARK: - Constants
    private let roundRadius: CGFloat = 8.0

    // MARK: - UIComponets
    private lazy var fieldsView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        view.roundedCornerColor(radius: roundRadius)
        return view
    }()

    lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.borderStyle = .roundedRect
        view.placeholder = R.string.localizable.placeholderEmail()
        view.textAlignment = .center
        return view
    }()

    lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.borderStyle = .roundedRect
        view.placeholder = R.string.localizable.placeholderPassword()
        view.textAlignment = .center
        return view
    }()

    lazy var enterButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .red
        view.setTitle(R.string.localizable.login(), for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.7967856526, green: 0.2607563436, blue: 0.1506694257, alpha: 1)
        view.roundedCornerColor(radius: roundRadius)
        return view
    }()

    private lazy var registerButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .darkGray
        return view
    }()

    //MARK: - Initializers
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    //MARK: - UISetup
    func buildViewHierarchy() {
        self.addSubview(fieldsView)
        self.fieldsView.addSubview(emailTextField)
        self.fieldsView.addSubview(passwordTextField)
        self.fieldsView.addSubview(enterButton)
    }

    func setupConstraints() {

        fieldsView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16).priority(900)
            make.width.lessThanOrEqualTo(400).priority(1000)
            make.center.equalToSuperview()
        }

        emailTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalTo(emailTextField)
            make.right.equalTo(emailTextField)
        }

        enterButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.equalTo(emailTextField)
            make.right.equalTo(emailTextField)
            make.bottom.equalTo(fieldsView.snp.bottom).inset(30)
        }
    }

    func setupAdditionalConfiguration() {

    }
}
