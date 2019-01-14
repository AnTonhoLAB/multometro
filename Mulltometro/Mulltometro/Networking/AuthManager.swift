//
//  FirebaseAuthManager.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Rswift

class AuthManager {
    
    
    private init() {}
    
    static func selfUser(completion: @escaping (Response<User>) -> Void) {
        let user: User =  CDManager.Object()
    
        CDManager.getSinlgeObject(user, completionHandler: { response in
            switch response {
            case .success(let user):
                completion(.success(user))
            case .failure(let err):
                completion(.failure(err))
            }
        })
    }
    
    static func isLogged() -> Bool {
        // TODO: - REFACTORING FIREBAE
        return false
    }
    
    static func getCurrentUserId() -> String {
        // TODO: - REFACTORING FIREBAE
        return "TODO"
    }
    
    static func setUser(name: String, completion: @escaping (Error?) -> Void) {
       // TODO: - REFACTORING FIREBAE
    }
    
    static func getCurrentEmail() -> String {
        // TODO: - REFACTORING FIREBAE
        return "TODO"
    }
    
    static func eraseLogData() {
       // TODO: - REFACTORING FIREBAE
    }
    
    static func login (email: String, password: String, completion: @escaping (Response<MulltometroUser>) -> Void) {
        let param = [
            "email": email,
            "password": password
        ]
        
        HTTPRequester.request(route: .auth, function: .login, parameters: param, completion: { response in
            
        })
    }
    
    static func createUser(with email: String, password: String, completion: @escaping(Response<MulltometroUser>) -> Void) {
       // TODO: - REFACTORING FIREBAE
    }
    
    static func logout(completion: @escaping(Response<Bool>) -> Void) {
        // TODO: - REFACTORING FIREBAE
    }
}
