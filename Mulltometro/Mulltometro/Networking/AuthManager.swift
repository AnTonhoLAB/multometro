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
    
    static func garb() {
       print( Auth.auth().currentUser?.refreshToken)
    }
    
    static func configureService() {
         FirebaseApp.configure()
    }
    
    static func isLogged() -> Bool {
        return Auth.auth().currentUser == nil ? false : true
    }
    
    static func getCurrentUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func setUser(name: String, completion: @escaping (Error?) -> Void) {
        guard let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() else { return completion(nil) }
        
        changeRequest.displayName = name
        changeRequest.commitChanges { err in
            completion(err)
        }
    }
    
    static func getCurrentEmail() -> String {
        return Auth.auth().currentUser?.email ?? ""
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
    
    static func createUser(with email: String, password: String, completion: @escaping(Response<AuthDataResult>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (res, error) in
            if let error = error {
                completion(Response.failure(error))
            } else if let res = res {
                do{
                    try Auth.auth().signOut()
                    completion(Response.success(res))
                }catch{
                     completion(Response.failure(error))
                }
            }
        }
    }
}
