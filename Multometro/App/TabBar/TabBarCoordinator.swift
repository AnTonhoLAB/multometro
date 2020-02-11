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
    case profile
}

class TabBarCoordinator: BaseCoordinator {
    let tabBarController: UITabBarController
    weak var delegate: TabBarCoordinatorFlowProtocol?

    override func start() {
//        let loginCoordinator = LoginCoordinator()
//        let listTabBarItem = UITabBarItem(title: TabBarItem.list.rawValue, image:  #imageLiteral(resourceName: "list"), selectedImage: #imageLiteral(resourceName: "list"))
//        listTabBarItem.tag = 0
//        loginCoordinator.rootViewController.tabBarItem = listTabBarItem
//
//        addChild(coordinator: loginCoordinator)
//        loginCoordinator.start()

//        let profileCoordinator = ProfileCoordinator()
//        let profileTabBarItem = UITabBarItem(title: TabBarItem.profile.rawValue, image: #imageLiteral(resourceName: "profile"), selectedImage: #imageLiteral(resourceName: "profile"))
//        profileTabBarItem.tag = 1
//        profileCoordinator.rootViewController.tabBarItem = profileTabBarItem
//
//        addChild(coordinator: profileCoordinator)
//        profileCoordinator.start()

//        tabBarController.setViewControllers([loginCoordinator.rootViewController,],
//                                             animated: true)
       }

    override init() {
        tabBarController = UITabBarController()
        super.init()
    }
}
