//
//  CoordinatorFactory.swift
//  Multometro
//
//  Created by George Gomes on 10/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeAuthCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {

    // MARK: - CoordinatorFactoryProtocol

    func makeAuthCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
}
