//
//  Response.swift
//  Multometro
//
//  Created by George Gomes on 28/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(Error)
}

enum SaveUserResponse<T> {
    case success(T)
    case errorOnImage(Error)
    case errorOnUser(Error)
    case error(Error)
}

enum SaveUserError {
    case errorOnImage
    case errorOnUser
    case error
}

extension SaveUserError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .errorOnImage:
            return NSLocalizedString(R.string.localizable.imageError(), comment: R.string.localizable.imageErrorDescription())
        case .errorOnUser:
            return NSLocalizedString(R.string.localizable.userError(), comment: R.string.localizable.userErrorDescription())
        case .error:
            return NSLocalizedString(R.string.localizable.userError(), comment: R.string.localizable.userErrorDescription())
        }
    }
}
