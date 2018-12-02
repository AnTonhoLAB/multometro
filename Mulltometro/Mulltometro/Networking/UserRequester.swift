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
//        syncUser()
//        timer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(UserRequester.syncUser), userInfo: nil, repeats: true)
    }
    
    @objc private class func syncUser() {
        let uid = ["uid": AuthManager.getCurrentUserId()]
        function.httpsCallable("syncUser").call(uid) { res, _ in
            
            if let res = res {
                do {
                    guard let value = res.data as? [String: Any] else { return }
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let user = try JSONDecoder().decode(MulltometroUser.self, from: jsonData)
                    
                    let userToSave = user.toCDObject()
                    CDManager.saveThis(userToSave, .user, completionHandler: { (err) in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 240 , execute: {
                            syncUser()
                        })
                    })
                } catch {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 240 , execute: {
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

    class func createUser(with user: MulltometroUser, and image: UIImage, completion: @escaping (SaveUserResponse<MulltometroUser?>) -> Void) {
        let uid = AuthManager.getCurrentUserId()
        let imageName:String = String("\(uid).png")
        let reference = Storage.storage().reference()
        let storageRef = reference.child(imageName)
        
        var imageRes = 0
        var saveUserRes = 0
        user.photoURL = imageName
        user.uid = uid
        user.email = AuthManager.getCurrentEmail()
        
        var userRes: MulltometroUser?
        
        // SEMAFORO
        
        // SEMAFORO DOWN
        // Fazer upload da imagem { // SE ERRO = Chamar Completion ELSE SEMAFORO UP }
        // SEMAFORO DOWN
        // Criar usuário { // SE ERRO = Chamar Completion ELSE SEMAFORO UP}
        
        //SEMAFORO DOWN
        // Chamar completion
        
        if let uploadData = image.jpegData(compressionQuality: 0.5){
            storageRef.putData(uploadData, metadata: nil, completion: { metadata, err in
                if err == nil {
                    imageRes = 1
                    if saveUserRes == 1 {
                        completion(.success(userRes))
                    } else if saveUserRes == -1 {
                        completion(.errorOnUser(SaveUserError.errorOnUser))
                    }
                } else {
                    imageRes = -1
                    if saveUserRes == 1 {
                        completion(.errorOnImage(SaveUserError.errorOnImage))
                    } else if saveUserRes == -1 {
                        completion(.error(SaveUserError.error))
                    }
                }
            })
        } else {
            imageRes = -1
        }
        
        let userToSave = user.dictionary
     
        function.httpsCallable("addUser").call(userToSave) { (res, err) in
            if err == nil {
                var value = res!.data as! [String: Any]
                value["firstTime"] = false
                let jsonData = try! JSONSerialization.data(withJSONObject: value, options: [])
                userRes = try! JSONDecoder().decode(MulltometroUser.self, from: jsonData)
                saveUserRes = 1
                if imageRes == 1 {
                    completion(.success(userRes))
                } else if imageRes == -1 {
                    completion(.errorOnImage(SaveUserError.errorOnImage))
                }
            } else {
                saveUserRes = -1
                if imageRes == 1 {
                    completion(.error(SaveUserError.error))
                } else if imageRes == -1 {
                    completion(.error(SaveUserError.error))
                }
            }
        }
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
