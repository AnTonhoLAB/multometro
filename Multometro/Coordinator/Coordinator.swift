//
//  CoordinatorCoordinator.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childs: [Coordinator] { get set }
    func start()
    func start(with option: DeepLinkOption?)
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        childs.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        childs = childs.filter { $0 !== coordinator }
    }
}
