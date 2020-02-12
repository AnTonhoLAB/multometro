//
//  LoginUseCase.swift
//  Multometro
//
//  Created by George Gomes on 12/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

protocol LoginUseCaseProtocol: BaseUseCase {
    func login(email: String, password: String, completion: @escaping (Response<MultometroUser>) -> Void)
}

final class LoginUseCase: LoginUseCaseProtocol {

    private var authRequester: AuthRequestable
    
    init(authRequester: AuthRequestable) {
        self.authRequester = authRequester
    }
    
    func login(email: String, password: String, completion: @escaping (Response<MultometroUser>) -> Void) {
        guard hasNetworking else { completion(.failure(RequestError.noConnection)); return }
        authRequester.login(email: email, password: password) { (response) in

            switch response {
            case .success(let userAndToken):
                completion(self.save(userAndToken))
            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

    private func save(_ userAndToken: UserAndToken) -> Response<MultometroUser> {
        let keychainToken = KeychainHelper(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.account, accessGroup: KeychainConfiguration.accessGroup)
        do {
            try keychainToken.savePassword(userAndToken.token)
            return.success(userAndToken.user)
        } catch {
            return .failure(KeychainError.notPossibleToSave)
        }
    }
}

//import Foundation

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
