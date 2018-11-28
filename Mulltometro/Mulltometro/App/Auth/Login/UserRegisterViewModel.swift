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
    
    var email: String!
    var password: String!
    var confirmPassword: String!
    
    init(email: String, password: String, confirmPassword: String) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    func validate() throws {
        //RegEx to test email
        let emailRegEx = R.string.strings.emailRegEx()
        let emailTest = NSPredicate(format: R.string.strings.format("%@"), emailRegEx)
        
        if !emailTest.evaluate(with: email){
            throw ValidatingError.invalidEmail
        }
        if password.count <= 6 {
            throw ValidatingError.invalidPassword
        }
        if password != confirmPassword {
            throw ValidatingError.samePassword
        }
    }
    
    func onCadastrar(dados: Dados){
        
        do {
            try valida(nome: dados.nome)
            try valida(senha: dados.senha)
        } catch {
            print(error)
        }
        
    }
    
    func valida(nome: String) throws {
        if nome.count < 3{
            throw ValidatingError.invalidName
        }
    }
    
    func valida(senha: String) throws {
        if senha.count < 6{
            throw ValidatingError.invalidPassword
        }
    }
}

struct Dados {
   var nome: String
   var senha: String
}


