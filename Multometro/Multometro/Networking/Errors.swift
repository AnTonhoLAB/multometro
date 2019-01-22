//
//  Errors.swift
//  Multometro
//
//  Created by George Gomes on 16/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noConnection
    case fail
    case failServerCrip
    case wrongUserOrPassword
    case emailAlreadyBeingUsed
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        let empty = ""
        switch self {
        case .noConnection:
             return NSLocalizedString(R.string.localizable.errorNoConnection(), comment: empty)
        case .fail:
            return NSLocalizedString(R.string.localizable.errorName(), comment: empty)
        case .failServerCrip:
            return NSLocalizedString(R.string.localizable.errorServer(100), comment: empty)
        case .wrongUserOrPassword:
            return NSLocalizedString(R.string.localizable.errorWrongEmailOrPassowrd(101), comment: empty)
        case .emailAlreadyBeingUsed:
            return  NSLocalizedString(R.string.localizable.errorEmailAlreadyBeingUsed(102), comment: empty)
        }
    }
}

extension RequestError {
    
    init(code: Int) {
        switch code {
            case 1: self = .noConnection
            case 101: self = .wrongUserOrPassword
            case 102: self = .emailAlreadyBeingUsed
            default: self = .fail
        }
    }
    
}
