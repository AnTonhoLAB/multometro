//
//  ExtensionString.swift
//  Multometro
//
//  Created by George Gomes on 19/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

extension String {
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        let simpleString = String(data: data, encoding: .utf8)!
        return simpleString
    }

    func decode() -> String? {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
}
