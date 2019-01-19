//
//  UserInRoom.swift
//  Multometro
//
//  Created by George Gomes on 17/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

class UserInRoom: Codable {
    var userType: String
//    "enterDate": "2019-01-17T18:48:22.000Z",
    var mulltometroUserId: Int
    var roomId: Int
    var user: MultometroUser?
}
