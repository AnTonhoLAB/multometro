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

    struct Input {
        let name: Observable<String>
        let password: Observable<String>
        let didTapLogin: Observable<Void>
    }

    struct Output {
        let isValid: Driver<Bool>
        let open: Driver<Void>
    }

    init() {

    }

    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        let isValid = Observable
            .combineLatest(input.name.asObservable(), input.password.asObservable()) {
            return self.isValidEmail($0) && $1.count >= 6
        }
        .asDriver(onErrorJustReturn: false)

        let open = input.didTapLogin.asDriver(onErrorJustReturn: ())

        return Output(isValid: isValid, open: open)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
