//
//  Room.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Room: Codable {
    
    var uid: String?
    var admin: MulltometroUser?
    var nameRoom: String!
    var fees: [Fee]?
    var appliedFee: [AppliedFee]?
    var users: [MulltometroUser]?
    var dueDate: Int!
    var created: Date!
    
    init() {
 
    }
    
    init(admin: MulltometroUser, name: String, dueDate: Int, created: Date? = Date()) {
        self.admin = admin
        self.nameRoom = name
        self.dueDate = dueDate
        self.created = created
    }
    
    init(likeUserTo admin: User, name: String, fees: [Fee]?, dueDate: Int, created: Date? = Date()) {
        
//        self.admin = admin
//        self.users = [admin]
        self.nameRoom = name
        self.fees = fees
        self.dueDate = dueDate
        self.created = created
        
        if  let name = admin.name, let email = admin.email, let photo = admin.pthotoURL {
            let user = MulltometroUser(uid: Int(admin.uid), name: name, email: email, photoURL: photo)
            self.admin = user
            self.users = [user]
        }
    }
    
    init(admin: User, name: String, fees: [Fee]?, dueDate: Int, created: Date? = Date()) {
        self.nameRoom = name
        self.fees = fees
        self.dueDate = dueDate
        self.created = created
        if  let name = admin.name, let email = admin.email, let photo = admin.pthotoURL {
            self.admin = MulltometroUser(uid: Int(admin.uid), name: name, email: email, photoURL: photo)
        }
    }
    
    init(name: String, fees: [Fee]?, adminUid: String, users: [String]?, dueDate:Int, created: Date? = Date()) {
//        self.admin = AuthManager.selfUser
        self.nameRoom = name
        self.dueDate = dueDate
        self.fees = fees
//        self.adminId = adminUid
//        self.users = users
        self.created = created
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
