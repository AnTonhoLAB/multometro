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
    }

    struct Output {
        let isValid: Driver<Bool>
        let networkingStatus: Observable<NetworkingState<MultometroUser>>
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

        /// Execute Login after did tap button

        let userInputs = Observable.combineLatest(input.name, input.password) { (login, password) -> (String, String) in
            return (login, password)
        }

        let authResponse = input.didTapLogin
            .withLatestFrom(userInputs)
            .flatMap { (email, password) in
                return self.loginUseCase.rxLogin(email: email, password: password)
        }.asObservable()

//        .asDriver(onErrorJustReturn: (
//                .fail(RequestError.fail)
//            ))


//        var open: Driver<NetworkingState<MultometroUser>>
//
//        input.didTapLogin.bind(onNext: { (_) in
//            open = self.loginUseCase.rxLogin(email: "", password:"").asDriver(onErrorJustReturn: .fail(RequestError.failServerCrip))
//        })

//            .asDriver(onErrorJustReturn: ())


        return Output(isValid: isValidLogin, networkingStatus: authResponse)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
