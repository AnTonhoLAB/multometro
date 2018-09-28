//
//  Response.swift
//  Mulltometro
//
//  Created by George Gomes on 28/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(Error)
}
