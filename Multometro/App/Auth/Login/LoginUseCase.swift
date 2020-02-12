//
//  LoginUseCase.swift
//  Multometro
//
//  Created by George Gomes on 12/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginUseCaseProtocol: BaseUseCase {
    func login(email: String, password: String, completion: @escaping (Response<MultometroUser>) -> Void)
    func rxLogin(email: String, password: String) -> Observable<NetworkingState<MultometroUser>>
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
                let savedResult = self.saveFail(userAndToken)//(userAndToken)
                completion(savedResult)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func rxLogin(email: String, password: String) -> Observable<NetworkingState<MultometroUser>>  {
        return Observable<NetworkingState>.create{ observer in
            observer.onNext(.loading)
            self.authRequester.login(email: email, password: password) { (response) in
                switch response {
                    case .success(let userAndToken):
                        self.save(userAndToken, observer: observer)
                    case .failure(let error):
                        observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    private func save(_ userAndToken: UserAndToken, observer: AnyObserver<NetworkingState<MultometroUser>>) {
        let keychainToken = KeychainHelper(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.account, accessGroup: KeychainConfiguration.accessGroup)
        do {
            try keychainToken.savePassword(userAndToken.token)
            observer.onNext(.success(userAndToken.user))
        } catch {
            observer.onError(KeychainError.notPossibleToSave)
        }
    }

    ///APAGAR
    func rxLoginFail(email: String, password: String) -> Observable<Response<MultometroUser>>  {
        return Observable<Response<MultometroUser>>.create{ observer in

            self.authRequester.login(email: email, password: password) { (response) in

                switch response {
                    case .success(let userAndToken):
                        let savedResult = self.saveFail(userAndToken)
                        observer.onNext(savedResult)
                    case .failure(let error):
                        observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    private func saveFail(_ userAndToken: UserAndToken) -> Response<MultometroUser> {
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
