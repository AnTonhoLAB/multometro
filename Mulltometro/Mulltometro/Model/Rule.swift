//
//  Tax.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Rule: Codable {

    var id: Int!
    var name: String!
    var valuePerFee: Int!
    var valueType: String!
    var symbol: String!
    var description: String?
//    var createdAt: Date!
  
//    "description": "multa para quem se atrasa",
//    "roomId": 11,
//    "createdAt": "2019-01-17T18:48:22.000Z",
//    "updatedAt": "2019-01-17T18:48:22.000Z"
    
    init(name: String, valuePerType: Int, valueType: String!, simbleType: String) {
        self.name = name
        self.valuePerFee = valuePerType
        self.valueType = valueType
        self.symbol = simbleType
    }
    
    init() {}
}

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    static let iso8601noFS = ISO8601DateFormatter()
}
