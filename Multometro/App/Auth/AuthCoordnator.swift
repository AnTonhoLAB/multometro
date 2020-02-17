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

    var finishFlow: (() -> Void)?

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    override func start() {
        self.openLogin()
    }

    private func openLogin() {
        let loginVC = self.viewControllerFactory.instantiateLoginViewController()
        loginVC.flowDelegate = self
        self.router.setRootModule(loginVC, hideBar: true)
    }

    private func openRegister() {
        let registerViewController = viewControllerFactory.instantiateRegisterViewController()
    //        registerVC.onBack = { [unowned self] in
    //            self.router.popModule()
    //        }
    //        registerVC.onRegister = { [unowned self] in
    //            self.router.popModule()
    //        }
        self.router.push(registerViewController, hideBar: false)
    }
}

extension AuthCoordinator: LoginFlowDelegate {
    func onLogin() {
        finishFlow?()
    }

    func onRegister() {
        openRegister()
    }

    func onChangePassword() {
//        self.showForgetPassword(module: loginVC)
    }
}


/*
 final class TabCoordinator: NSObject, Coordinator {

 var rootViewController: UIViewController {
     return tabController
 }

 let tabController: UITabBarController

 let homeCoordinator: HomeCoordinator
 let historyCoordinator: HistoryCoordinator
 let profileCoordinator: ProfileCoordinator

 var coordinators: [Coordinator] {
     return [homeCoordinator, historyCoordinator, profileCoordinator]
 }

 init(client: HTTPClient, persistence: Persistence) {

     tabController = UITabBarController()

     homeCoordinator = HomeCoordinator(client: client, persistence: persistence)

     historyCoordinator = HistoryCoordinator(client: client, persistence: persistence)

     profileCoordinator = ProfileCoordinator(client: client, persistence: persistence)

     var controllers: [UIViewController] = []

     let homeViewController = homeCoordinator.rootViewController
     homeViewController.tabBarItem = UITabBarItem(title: Localization.homeTab.string, image: Asset.iconMenuRecharge.image, selectedImage: Asset.iconMenuRechargeActivated.image)

     let historyViewController = historyCoordinator.rootViewController
     historyViewController.tabBarItem = UITabBarItem(title: Localization.walletTab.string, image: Asset.iconMenuWallet.image, selectedImage: Asset.iconMenuWalletActivated.image)

     let profileViewController = profileCoordinator.rootViewController
     profileViewController.tabBarItem = UITabBarItem(title: Localization.profileTab.string, image: Asset.iconMenuProfile.image, selectedImage: Asset.iconMenuProfileActivated.image)

     super.init()

     controllers.append(homeViewController)
     controllers.append(historyViewController)
     controllers.append(profileViewController)

     tabController.viewControllers = controllers
     tabController.tabBar.isTranslucent = false
     tabController.delegate = self

 }
*/
