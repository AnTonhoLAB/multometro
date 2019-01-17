//
//  Errors.swift
//  Mulltometro
//
//  Created by George Gomes on 16/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case fail
    case wrongUserOrPassword
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fail:
            return NSLocalizedString(R.string.localizable.errorName(), comment: R.string.localizable.error())
        case .wrongUserOrPassword:
            return NSLocalizedString(R.string.localizable.errorWrongEmailOrPassowrd(), comment: R.string.localizable.errorWrongEmailOrPassowrd())
        }
    }
}

extension RequestError {
    
    init(code: Int) {
        switch code {
            case 404: self = .wrongUserOrPassword
            default: self = .fail
        }
    }
    
}
