//
//  UserInRoom.swift
//  Multometro
//
//  Created by George Gomes on 17/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

enum UserType: String, Codable{
    case ADMIN
    case ADMINUSER = "ADMIN/USER"
    case USER
}

class UserInRoom: Codable {
    var userType: UserType!
//    "enterDate": "2019-01-17T18:48:22.000Z",
    var mulltometroUserId: Int
    var roomId: Int
    var mulltometroUser: MultometroUser!
}

