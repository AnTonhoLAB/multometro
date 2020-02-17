//
//  ViewControllerFactory.swift
//  Multometro
//
//  Created by George Gomes on 10/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import UIKit

final class ViewControllerFactory {

    func instantiateLoginViewController() -> LoginViewController {
        let loginView = LoginView()
        let authRequester = AuthRequester()
        let loginUseCase = LoginUseCase(authRequester: authRequester)
        let loginViewModel = LoginViewModel(loginUseCase)
        let loginVC = LoginViewController(with: loginView, and: loginViewModel)
        return loginVC
    }

    func instantiateRegisterViewController() -> RegisterViewController {
        let registerView = RegisterView()
        let registerRequester = AuthRequester()
        let registerUseCase = RegisterUseCase(authRequester: registerRequester)
        let registerViewModel = RegisterViewModel(registerUseCase)
        let registerViewController = RegisterViewController(with: registerView, and: registerViewModel)
        return registerViewController
    }

//    func instantiateTabBarrController() -> MainTabBarController {
//        let tabBarController = MainTabBarController()
//        return  tabBarController
//    }

    func instantiateGroupsViewController() -> GroupsViewController {
        let groupsView = GroupsView()
        let authRequester = AuthRequester()
        let groupsUseCase = GroupsUseCase(authRequester: authRequester)
        let groupsViewModel = GroupsViewModel(groupsUseCase)
        let groupsVC = GroupsViewController(with: groupsView, and: groupsViewModel)
        return groupsVC
    }
}
