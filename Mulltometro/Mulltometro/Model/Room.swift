//
//  Room.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Room: Codable {
    
    var id: String!
    var name: String!
    var taxesTypes: [Tax]!
    var adminUid: String!
    var users: [MulltometroUser]!
    
    init(name: String, taxesTypes: [Tax], adminUid: String, users: [MulltometroUser] ) {
        self.name = name
        self.taxesTypes = taxesTypes
        self.adminUid = adminUid
        self.users = users
    }
}
