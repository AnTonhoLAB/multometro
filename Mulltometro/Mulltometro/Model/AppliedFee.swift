//
//  AppliedFee.swift
//  Mulltometro
//
//  Created by George Gomes on 07/12/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class AppliedFee: Codable {
    
    var nameFee: String!
    var valuePerType: Int!
    var valueType: String!
    var simbleType: String!
    
    var dueDate: Date!
    var applyDate: Date!
    var user: MulltometroUser!
    var room: Room!
    
    init(nameFee: String, valuePerType: Int, valueType: String, simbleType: String,
         dueDate: Date, applyDate: Date, user: MulltometroUser, room: Room) {
        
        self.nameFee = nameFee
        self.valuePerType = valuePerType
        self.valueType = valueType
        self.simbleType = simbleType
        
        self.dueDate = dueDate
        self.applyDate = applyDate
        self.user = user
        self.room = room
    }
}
