//
//  UserRequester.swift
//  Multometro
//
//  Created by George Gomes on 10/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Rswift

class UserRequester {
    
    class func getMyUser(completion: @escaping (Response<MultometroUser>) -> Void) {
        // TODO: - REFACTORING FIREBAE
    }
    
    class func checkUser(completion: @escaping (Bool) -> Void) {
        // TODO: - REFACTORING FIREBAE
        //function.httpsCallable("setupUser").call(uid) { res, err in
    }
    
    class func uploadUser(image: UIImage, completion: @escaping (Response<Bool>) -> Void) {
       // TODO: - REFACTORING FIREBAE
    }
    
    class func uploadUser(name: String, completion: @escaping (Response<MultometroUser>) -> Void ) {
        // TODO: - REFACTORING FIREBAE
    }
    
    class func saveLocally(user: MultometroUser) {
        let userToSave = user.toCDObject()
        CDManager.saveThis(userToSave, completionHandler: { (err) in
            guard (err == nil) else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 20 , execute: {
                    self.saveLocally(user: user)
                })
                return
            }
        })
    }
}

extension User {
    
//    func setData(name: String, email: String, uid: String, firstTime: Bool) {
//        self.name = name
//        self.email = email
//        self.uid = uid
//        self.firstTime = firstTime
//    }
    
}
