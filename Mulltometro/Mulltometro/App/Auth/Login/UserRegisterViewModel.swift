//
//  UserRegisterViewModel.swift
//  Mulltometro
//
//  Created by George Gomes on 17/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

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
        
        if name.count < 3 {
            throw ValidatingError.invalidName
        }
        
        
        
    }
    
}

enum ValidatingError: Error {
    case invalidName
    case invalidEmail
    case samePassword
    case insufficientFunds(coinsNeeded: Int)
}
