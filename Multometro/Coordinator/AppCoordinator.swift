//
//  AppCoordinator.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit

enum DeepLinkOption {
    case login
    case `default`
}

private enum AppCoordinatorTransition {
    case goToOnboarding
    case goToStore
    case goToAdditionalInfo
}

final class AppCoordinator: BaseCoordinator {

    // MARK: - Vars & Lets

    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private var launchInstructor = LaunchInstructor().configure()
    private let viewControllerFactory: ViewControllerFactory = ViewControllerFactory()

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }


    override func start() {
        runMainFlow()
    }

    override func start(with option: DeepLinkOption?) {
        
        if option != nil {

        } else {
           switch launchInstructor {
           case .onboarding: runOnboardingFlow()
           case .auth: runAuthFlow()
           case .main: runMainFlow()
           }
       }
    }

    private func runOnboardingFlow() {

    }

    private func runAuthFlow() {
        let authCoordinator = coordinatorFactory.makeAuthCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        authCoordinator.authFlowDelegate = self
        authCoordinator.finishFlow = { [unowned self, unowned authCoordinator] in
            self.removeDependency(authCoordinator)
            self.launchInstructor = LaunchInstructor().configure(tutorialWasShown: true)
            self.start(with: nil)
        }
        self.addChild(coordinator: authCoordinator)
        authCoordinator.start()
    }

    private func runMainFlow() {
        let tabCoordinator = coordinatorFactory.makeTabBarCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)


//        tabCoordinator.
//        tabCoordinator.delegate = self
        self.addChild(coordinator: tabCoordinator)
        tabCoordinator.start()
//        window.rootViewController = tabCoordinator.tabBarController
//        tabCoordinator.isCompleted = { [weak self] in
//            guard let weakSelf = self else {
//                fatalError("Unable to reference self.")
//            }
//            weakSelf.removeChild(coordinator: weakSelf.tabCoordinator!)
//        }

    }
}

extension AppCoordinator: AuthFlowDelegate {
    func finishFlow() {
//        self.removeDependency(coordinator)
//        self.launchInstructor = LaunchInstructor.configure(tutorialWasShown: false, isAutorized: true)
//        self.start()
    }
}

extension AppCoordinator {
    fileprivate func handle(transition: AppCoordinatorTransition) {

    }
}

extension AppCoordinator: TabBarCoordinatorFlowProtocol {
    func goToOnboarding() {
        self.handle(transition: .goToOnboarding)
    }
}
