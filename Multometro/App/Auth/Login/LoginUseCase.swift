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
    func login(email: String, password: String) -> Observable<NetworkingState<MultometroUser>>
}

final class LoginUseCase: LoginUseCaseProtocol {

    private var authRequester: AuthRequestable
    
    init(authRequester: AuthRequestable) {
        self.authRequester = authRequester
    }

    func login(email: String, password: String) -> Observable<NetworkingState<MultometroUser>>  {
        return Observable<NetworkingState>.create{ observer in
            observer.onNext(.loading)
            self.authRequester.login(email: email, password: password) { (response) in
                self.processResponse(observer: observer, response: response)
            }
            return Disposables.create()
        }
    }

    private func processResponse(observer: AnyObserver<NetworkingState<MultometroUser>>, response: Response<UserAndToken>) {
        switch response {
            case .success(let userAndToken):
                self.save(userAndToken, observer: observer)
            case .failure(let error):
                observer.onNext(.fail(error))
        }
    }

    private func save(_ userAndToken: UserAndToken, observer: AnyObserver<NetworkingState<MultometroUser>>) {

        let keychainToken = KeychainHelper(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.account, accessGroup: KeychainConfiguration.accessGroup)
        do {
            try keychainToken.savePassword(userAndToken.token)
            observer.onNext(.success(userAndToken.user))
        } catch {
            observer.onNext(.fail(error))
        }
    }
}

//import Foundation

