//
//  User.swift
//  Multometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import CoreData

class MultometroUser: Codable {
   
    var id: Int!
    var userName: String!
    var email: String!
    var photoURL: String?
    var rooms: [Room]?
    var firstTime: Bool?
    var bio: String?
    var password: String?

//    "password": "$2a$10$HkwS3CICU4qQWRjoD757s.pd6SOdcmdu/tm7MPqx5vX0jrH2BLCzu",
//    "bio": null,
//    "firstTime": true,
//    "createdAt": "2019-01-04T19:06:53.000Z",
//    "updatedAt": "2019-01-04T19:06:53.000Z"
    
    init(name: String, email: String, rooms: [Room]) {
        self.userName = name
        self.email = email
        self.rooms = rooms
    }
    
    init(uid: Int, name: String, email: String) {
        self.id = uid
        self.userName = name
        self.email = email
        self.firstTime = false
    }
    
    init(uid: Int, name: String, email: String, photoURL: String) {
        self.id = uid
        self.userName = name
        self.email = email
        self.photoURL = photoURL
        self.firstTime = false
    }
    
    init() {
        
    }
    
    func toCDObject() -> User {
        let user: User = CDManager.Object()
        user.email = self.email
        user.uid = Int64(self.id)
        user.firstTime = false
        user.name = self.userName
        user.pthotoURL = self.photoURL
        
        return user
    }
    
    init(from json: [String:Any]) {
        
    }
}
