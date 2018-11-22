//
//  Tax.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Fee: Codable {

    var nameFee: String!
    var valuePerType: Int!
    var valueType: String!
    var simbleType: String!
    
    init(name: String, valuePerType: Int, valueType: String!, simbleType: String) {
        self.nameFee  = name
        self.valuePerType = valuePerType
        self.valueType = valueType
        self.simbleType = simbleType
    }
    
    init() {}
}
