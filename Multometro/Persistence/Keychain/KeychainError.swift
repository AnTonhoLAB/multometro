//
//  KeychainError.swift
//  Multometro
//
//  Created by George Gomes on 12/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case notPossibleToSave
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
