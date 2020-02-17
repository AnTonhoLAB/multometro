//
//  LoginViewModel.swift
//  Multometro
//
//  Created by George Gomes on 07/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

final class LoginViewModel: ViewModelType {

    private var loginUseCase: LoginUseCase

    struct Input {
        let name: Observable<String>
        let password: Observable<String>
        let didTapLogin: Observable<Void>
        let didTapRegister: Observable<Void>
    }

    struct Output {
        let isValid: Driver<Bool>
        let openRegister: Driver<Void>
        let networkingStatus: Driver<NetworkingState<MultometroUser>>
    }

    init(_ loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {

        /// Check fields to enable login button
        let isValidLogin = Observable
            .combineLatest(input.name.asObservable(), input.password.asObservable()) {
            return self.isValidEmail($0) && $1.count >= 6
        }
        .asDriver(onErrorJustReturn: false)

        /// Login Execution
        /// Get user informations on textfields
        let userInputs = Observable.combineLatest(input.name, input.password) { (login, password) -> (String, String) in
            return (login, password)
        }
        /// Execute Login after did tap button
        let authResponse = input.didTapLogin
            .withLatestFrom(userInputs)
            .flatMap { (email, password) in
                return self.loginUseCase.login(email: email, password: password)
            }
            .asDriver(onErrorJustReturn: (.fail(RequestError.fail)))

        /// Open register screen
        let openRegister = input
            .didTapRegister
            .asDriver(onErrorJustReturn: ())

        /// Return outputs
        return Output(isValid: isValidLogin, openRegister: openRegister, networkingStatus: authResponse)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
