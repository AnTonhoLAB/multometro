//
//  FirebaseAuthManager.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthManager {
    
    private init() {}
    
    static func configureService() {
         FirebaseApp.configure()
    }
    
    static func isLogged() -> Bool {
        return Auth.auth().currentUser == nil ? false : true
    }
    
    static func eraseLogData() {
        do {
            try Auth.auth().signOut()
        } catch { }
    }
    
    static func login (user: String, password: String, completion: @escaping (Response<Any>) -> Void) {
        Auth.auth().signIn(withEmail: user, password: password) { (res, err) in
            if let err = err {
                completion(Response.failure(err))
            } else if let res = res {
                completion(Response.success(res))
            }
        }
    }
}
