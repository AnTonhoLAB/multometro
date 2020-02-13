//
//  Tabbar.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit

protocol TabBarCoordinatorFlowProtocol: class {
    func goToOnboarding()
}

fileprivate enum TabBarItem: String {
    case list
//    case profile
}

class TabBarCoordinator: BaseCoordinator {
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    private let tabBarController: MainTabBarController

    weak var delegate: TabBarCoordinatorFlowProtocol?


    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory


        self.tabBarController = viewControllerFactory.instantiateTabBarrController()
   }

    override func start() {
        
        let groupsCoordinator = self.coordinatorFactory.makeGroupsCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        
        self.addDependency(groupsCoordinator)
        tabBarController.setViewControllers([groupsCoordinator.rootViewController], animated: true)
        groupsCoordinator.start()
        self.router.setRootModule(self.tabBarController, hideBar: true)
    }

    private func setupGroupsCoordinator() {
//        let setupGroupsCoordinator = self.coordinatorFactory.makeGroupsCoordinatorBox


    }
}
