//
//  GroupsCoordinator.swift
//  Multometro
//
//  Created by George Gomes on 13/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit

protocol GroupFlowDelegate: class {
    func finishFlow()
}

class GroupsCoordinator: BaseCoordinator {

    let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

//    var rootViewController: UIViewController

    var groupFlowDelegate: GroupFlowDelegate?
    var finishFlow: (() -> Void)?

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    override func start() {
        self.showGroupViewController()
    }

    private func showGroupViewController() {
        let groupViewController = viewControllerFactory.instantiateGroupsViewController()
        self.router.setRootModule(groupViewController)
//        let groupVC =
//        loginVC.onLogin = { [unowned self] in
//            self.finishFlow?()
//        }
//        self.router.setRootModule(groupVC, hideBar: true)
    }
}

//extension AuthCoordinator: LoginFlowDelegate {
//    func onLogin() {
//        self.authFlowDelegate?.finishFlow()
//    }
//
//    func onRegister() {
////        self.showRegisterViewController()
//    }
//
//    func onChangePassword() {
////        self.showForgetPassword(module: loginVC)
//    }
//}
