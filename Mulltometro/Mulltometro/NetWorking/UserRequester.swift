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
        let storageRef = reference.child("profilePic").child(imageName)
        
        var imageRes = 0
        var saveUserRes = 0
        user.photoURL = imageName
        user.uid = uid
        user.email = AuthManager.getCurrentEmail()
        
        var userRes: MulltometroUser?
        
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
