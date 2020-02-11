//
//  LoginCoordnator.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit

protocol AuthFlowDelegate: class {
    func finishFlow()
}

class AuthCoordinator: BaseCoordinator {

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    var authFlowDelegate: AuthFlowDelegate?
    var finishFlow: (() -> Void)?

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    override func start() {
        self.showLoginViewController()
    }

    private func showLoginViewController() {
        let loginVC = self.viewControllerFactory.instantiateLoginViewController()
//        loginVC.onLogin = { [unowned self] in
//            self.finishFlow?()
//        }
        self.router.setRootModule(loginVC, hideBar: true)
    }
}

extension AuthCoordinator: LoginFlowDelegate {
    func onLogin() {
        self.authFlowDelegate?.finishFlow()
    }

    func onRegister() {
//        self.showRegisterViewController()
    }

    func onChangePassword() {
//        self.showForgetPassword(module: loginVC)
    }
}
