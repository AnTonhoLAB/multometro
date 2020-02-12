//
//  KeyChainManager.swift
//  Multometro
//
//  Created by George Gomes on 12/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

struct KeychainManager {

    init() {

    }

    func isLogged() -> Bool {
        let keychainToken = KeychainHelper(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.account, accessGroup: KeychainConfiguration.accessGroup)
        do {
            _ = try keychainToken.readPassword()
            return true
        } catch {
            return false
        }
    }

    func saveToken(with data: Data) throws {
        do {
            let userAndToken = try JSONDecoder().decode(UserAndToken.self, from: data)
            let keychainToken = KeychainHelper(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.account, accessGroup: KeychainConfiguration.accessGroup)
            try keychainToken.savePassword(userAndToken.token)
        } catch {
            throw  KeychainError.notPossibleToSave
        }
    }
}
