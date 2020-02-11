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
        let loginViewModel = LoginViewModel()
        let loginVC = LoginViewController(with: loginViewModel)
        return loginVC
    }

}
