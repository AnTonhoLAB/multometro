//
//  UserRegisterViewModel.swift
//  Multometro
//
//  Created by George Gomes on 17/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Rswift
import RxSwift
import RxCocoa

struct RegisterViewModel {
    
//    var email: String!
//    var password: String!
//    var confirmPassword: String!

    private var registerUseCase: RegisterCaseProtocol

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

    init(_ registerUseCase: RegisterCaseProtocol) {
        self.registerUseCase = registerUseCase
    }
    

    
    func validate() throws {
        //RegEx to test email
//        let emailRegEx = R.string.strings.emailRegEx()
//        let emailTest = NSPredicate(format: R.string.strings.format("%@"), emailRegEx)
//        
//        if !emailTest.evaluate(with: email){
//            throw ValidatingError.invalidEmail
//        }
//        if password.count < 6 {
//            throw ValidatingError.invalidPassword
//        }
//        if password != confirmPassword {
//            throw ValidatingError.samePassword
//        }
    }
}


