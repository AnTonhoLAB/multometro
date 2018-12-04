//
//  UserRequester.swift
//  Mulltometro
//
//  Created by George Gomes on 10/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Firebase
import Rswift

class UserRequester {
    private static var function = Functions.functions()
    
    private static var timer = Timer()
    class func startSync(){
         syncUser()
        //timer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(UserRequester.syncUser), userInfo: nil, repeats: true)
    }
    
    class func oneSyncUser() {
        syncUser()
    }
    
    @objc private class func syncUser() {
        let uid = ["uid": AuthManager.getCurrentUserId()]
        function.httpsCallable("syncUser").call(uid) { res, err in
            
            if let res = res {
                do {
                    guard let value = res.data as? [String: Any] else { return }
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let user = try JSONDecoder().decode(MulltometroUser.self, from: jsonData)
                    
                    let userToSave = user.toCDObject()
                    
                    CDManager.saveThis(userToSave, completionHandler: { (err) in
                        guard (err == nil) else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 20 , execute: {
                                syncUser()
                            })
                            return
                        }
                    })
                } catch {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 20 , execute: {
                        syncUser()
                    })
                }
            }
        }
    }
    
    class func checkUser(completion: @escaping (Bool) -> Void) {
        let uid = ["uid": AuthManager.getCurrentUserId()]
        
         function.httpsCallable("setupUser").call(uid) { res, err in
            if err == nil {
                completion(false)
            } else { //has error
                completion(true) // is first time in app
            }
        }
    }
    
    class func uploadUser(image: UIImage, completion: @escaping (Response<Bool>) -> Void) {
        let reference = Storage.storage().reference()
        let uid = AuthManager.getCurrentUserId()
        let imageName:String = String("\(uid).png")
        let storageRef = reference.child(imageName)
        
        
        if let uploadData = image.jpegData(compressionQuality: 0.5){
            storageRef.putData(uploadData, metadata: nil, completion: { _, err in
                if let err = err {
                   completion(Response.failure(err))
                } else {
                   completion(Response.success(true))
                }
            })
        } else {
            completion(.failure(SaveUserError.errorOnImage))
        }
    }
    
    class func uploadUser(name: String, completion: @escaping (Response<MulltometroUser>) -> Void ) {
        let userName = ["name": name,
                        "uid": AuthManager.getCurrentUserId()
                        ]
        
        function.httpsCallable("addUser").call(userName) { (res, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            if let res = res {
                let value = res.data as! [String: Any]
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let userRes = try JSONDecoder().decode(MulltometroUser.self, from: jsonData)
                    completion(.success(userRes))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    class func saveLocally(user: MulltometroUser) {
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
