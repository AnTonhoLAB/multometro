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
import Rswift

class AuthManager {
    
    private static var function = Functions.functions()
    
    private init() {}
    
    static func configureService() {
         FirebaseApp.configure()
    }
    
    static func isLogged() -> Bool {
        return Auth.auth().currentUser == nil ? false : true
    }
    
    static func getCurrentUserId() -> String {
//        guard let user = Auth.auth().currentUser else { return "" }
//        return user.uid
        return Auth.auth().currentUser?.uid ?? ""
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
                guard let user = res.user.email else { return }
                completion(Response.success(user))
            }
        }
    }
    
    static func createUser() {
        
    }
    
    static func add() {
        let datas = ["name": "George", "idade": "23"]
        
        function.httpsCallable("addAUser").call(["name": "Giorgino", "idade": "23"]) { res, err in
            print("res ",res?.data ?? "nao tem res")
            print("err", err ?? "nao tem err")
        }
        
        function.httpsCallable("addAUser").call(datas) { res, err in
            print("res ",res?.data ?? "nao tem res")
            print("err", err ?? "nao tem err")
        }
    }
}
