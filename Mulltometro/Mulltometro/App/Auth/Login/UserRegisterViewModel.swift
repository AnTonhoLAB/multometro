//
//  UserRegisterViewModel.swift
//  Mulltometro
//
//  Created by George Gomes on 17/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Rswift

struct UserRegisterViewModel {
    
    var name: String!
    var email: String!
    var password: String!
    var confirmPassword: String!
    
    init(name: String, email: String, password: String, confirmPassword: String) {
        self.name = name
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    func validate() throws {
        //RegEx to test email
        let emailRegEx = R.string.strings.emailRegEx()
        let emailTest = NSPredicate(format: R.string.strings.format("%@"), emailRegEx)
        
        if name.count < 3 {
            throw ValidatingError.invalidName
        }
        if !emailTest.evaluate(with: email){
            throw ValidatingError.invalidEmail
        }
        if password.count > 6 {
            throw ValidatingError.invalidPassword
        }
        if password != confirmPassword {
            throw ValidatingError.samePassword
        }
        
    }
    
}


