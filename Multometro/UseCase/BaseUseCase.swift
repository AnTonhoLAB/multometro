//
//  UseCaseBase.swift
//  Multometro
//
//  Created by George Gomes on 12/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

protocol BaseUseCase {

}

extension BaseUseCase {
    private var keyChainManager: KeychainManager  {
        get {
            return KeychainManager()
        }
    }

    var isLoged: Bool {
        return keyChainManager.isLogged()
    }

    var hasNetworking: Bool {
        return NetworkingManager.isConnected
    }
}
