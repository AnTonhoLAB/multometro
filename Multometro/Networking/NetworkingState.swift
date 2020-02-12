//
//  NetworkingState.swift
//  Multometro
//
//  Created by George Gomes on 12/02/20.
//  Copyright © 2020 CrowCode. All rights reserved.
//

import Foundation

enum NetworkingState<T> {
    case loading
    case success(T)
    case fail(Error)
    case `default`

    static func == (lhs: NetworkingState, rhs: NetworkingState) -> Bool {
        return lhs.id == rhs.id
    }

    var id: String  {
        switch self {
        case .loading:
            return "loading"
        case .success(_):
            return "succees"
        case .fail(_):
            return "fail"
        case .default:
            return "default"
        }
    }
}
