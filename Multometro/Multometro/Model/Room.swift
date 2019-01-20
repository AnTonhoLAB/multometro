//
//  Room.swift
//  Multometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Room: Codable {
    
    var id: Int!
    var name: String!
    var rules: [Rule]?
    var appliedFee: [AppliedFee]?
    var dueDate: Int!
    var createdAt: Date!
//    "color": "red"
    
    var userInRooms: [UserInRoom]!
    
    lazy var admin: UserInRoom = {
        let user = userInRooms.filter { $0.userType != .USER}
        return user[0]
    }()
    
    lazy var myUser: UserInRoom = {
        let user = userInRooms.filter { $0.mulltometroUserId == AuthManager.getCurrentUserId() }
        return user[0]
    }()
    
    init() {
 
    }
    
    init(admin: MultometroUser, name: String, dueDate: Int, created: Date? = Date()) {
//        self.admin = admin
        self.name = name
        self.dueDate = dueDate
//        self.createdAt = created
    }
    
    init(likeUserTo admin: User, name: String, fees: [Rule]?, dueDate: Int, created: Date? = Date()) {
        
//        self.admin = admin
//        self.users = [admin]
        self.name = name
        self.rules = fees
        self.dueDate = dueDate
//        self.createdAt = created
        
//        if  let name = admin.name, let email = admin.email, let photo = admin.pthotoURL {
//            let user = MultometroUser(uid: Int(admin.uid), name: name, email: email, photoURL: photo)
//            self.admin = user
//            self.users = [user]
//        }
    }
    
    init(admin: User, name: String, fees: [Rule]?, dueDate: Int, created: Date? = Date()) {
        self.name = name
        self.rules = fees
        self.dueDate = dueDate
//        self.createdAt = created
//        if  let name = admin.name, let email = admin.email, let photo = admin.pthotoURL {
////            self.admin = MultometroUser(uid: Int(admin.uid), name: name, email: email, photoURL: photo)
//        }
    }
    
    init(name: String, fees: [Rule]?, adminUid: String, users: [String]?, dueDate:Int, created: Date? = Date()) {
//        self.admin = AuthManager.selfUser
        self.name = name
        self.dueDate = dueDate
        self.rules = fees
//        self.adminId = adminUid
//        self.users = users
//        self.createdAt = created
    }
    
    init(completion: @escaping (Response<Bool>) -> Void) {
        
    }
}

struct SimpleUser {
    var name: String
    var email: String
    var firstTime: Bool
    var uid: String
}
