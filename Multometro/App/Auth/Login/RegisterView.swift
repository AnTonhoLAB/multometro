//
//  RegisterView.swift
//  Multometro
//
//  Created by George Gomes on 17/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RegisterViewComponents: UIView {
    /// To read UI informations
    var emailObservable: Observable<String> { get }
    var passwordObservable: Observable<String> { get }
    var enterObservable: Observable<Void> { get }
    /// To change UI informations
    var enterIsValide: Binder<Bool> { get }
}

class RegisterView: UIView, RegisterViewComponents {
    //MARK: - Observable Components
    lazy var emailObservable: Observable<String> = {
        return self.fieldsView.emailObservable
    }()

    lazy var passwordObservable: Observable<String> = {
        return self.fieldsView.passwordObservable
    }()

    lazy var repeatPassowrdObservable: Observable<String> = {
        return self.fieldsView.repeatPasswordObservable
    }()

    lazy var enterObservable: Observable<Void> = {
        return self.fieldsView.enterObservable
    }()

    lazy var enterIsValide: Binder<Bool> = {
        return  self.fieldsView.enterIsValide
    }()

    //MARK: - Constants
    private let roundRadius: CGFloat = 8.0

   // MARK: - UIComponets
    private lazy var fieldsView: AuthFormView = {
        let view = AuthFormView(authStep: .register)
        view.backgroundColor = .darkGray
        view.roundedCornerColor(radius: roundRadius)
        return view
    }()

    //MARK: - Initializers
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension RegisterView: CodeView {
    //MARK: - UISetup
    func buildViewHierarchy() {
        self.addSubview(fieldsView)
    }

    func setupConstraints() {

        fieldsView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16).priority(900)
            make.width.lessThanOrEqualTo(400).priority(1000)
            make.center.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {

    }
}
